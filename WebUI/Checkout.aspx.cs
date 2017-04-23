using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net.Mail;
using System.Text;
using System.Text.RegularExpressions;
using com.paypal.soap.api;
using System.Collections.Generic;
using System.Diagnostics;
using BusinessTier.DataAccessLayer;
using BusinessTier.Utility;
using BusinessTier.Shipping;
using BusinessTier.PayPal;

namespace WebUI
{

    // This page exists to host the checkout wizard.  This facilitates the web end-user's ability to pay for products.
    public partial class Checkout : System.Web.UI.Page
    {
        protected bool reloadShippingAddress;
        protected bool reloadBillingAddress;

        protected Cart.CartRow CartRow;
        protected Cart Cart;
        protected CheckoutTables.OrderRow m_Order;
        protected decimal salesTaxPercent = -1;
        protected bool isCompleteSaleInvalid;
        protected bool ReloadShippingOptions;

        protected ShippingOption[] options;
        protected CheckoutTables.AddressDataTable prev_addresses;

        protected Encryption theEncrypter = new Encryption();
        protected DataAccessLayer daLayer = new DataAccessLayer();

        protected DataScrubber dataScrubber = new DataScrubber();

        #region Methods

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            if (CheckoutWizard.ActiveStep.ID == "CompleteSale")
            {
                this.CalculatedTotal.Value = (this.CartRow.OrderSubTotal + ((m_Order.IsShippingOptionNull()) ? 0 : GetShippingOptionById(m_Order.ShippingOption).Cost) + ((OrderShippingAddress != null) ? TaxCost : 0)).ToString();
            }
        }

        private string StarOutString(string str, int exceptLast)
        {
            char[] retval = new char[str.Length];

            for (int i = 0; i < str.Length - exceptLast; ++i)
            {
                retval[i] = '*';
            }

            for (int i = str.Length - exceptLast; i < str.Length; ++i)
            {
                retval[i] = str[i];
            }

            return new string(retval);
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

             // It is time to enter HTTPS mode and stay there for the remainder of the session.
            if ((!Request.IsSecureConnection) & (System.Configuration.ConfigurationManager.AppSettings["https-mode"] == "yes"))
            {
                Response.Redirect(Request.Url.AbsoluteUri.Replace("http://", "https://"));
                return;
            }

            // TODO:  This should be refactored to be something to the effect of "if(!IsProfileSet())"
            if (!IsPostBack)
            {
                // This sets the Paypal object to load with the myriad of constants.
                PayPalProfile.SetDefaultProfile();
            }

            // Test to see if the user has logged in.  If they have not, route them to back to the login page.
            if (Session["LoginId"] == null)
            {
                Response.Redirect("Login.aspx?Referrer=Checkout.aspx");
            }

            // Verify that m_Order is locked and loaded before proceeding.
            if (m_Order == null)
            {
                // If m_Order is null, then retrieve it from the Database
                if (Session["OrderID"] != null)
                {
                    // Populate m_Order from the DB.
                    m_Order = daLayer.GetOrderByOrderID((int)Session["OrderID"]);
                }
                else
                {
                    // The (Session["OrderID"] was null, therefore create one.
                    m_Order = daLayer.CreateOrder((Guid)Session["myCartID"], (int)Session["LoginId"]);
                    Session["OrderID"] = m_Order.OrderId;
                   // TODO:  VERIFY The user should see an emtpy cart? yes, SG
                }
            }

            if (m_Order.Status == 'S')
            {
                Response.Redirect("Receipt.aspx?OrderNumber=" + m_Order.OrderId);
            }

        }

        protected void CompleteSale_Load(object sender, EventArgs e)
        {
            if (CartRow == null)
            {
                Cart = daLayer.GetCart(m_Order.CartId, (int)Session["LoginId"]);
                CartRow = Cart._Cart.FindByCartId(m_Order.CartId);
                this.CartRepeater.DataSource = Cart.CartLine;
                this.CartRepeater.DataBind();
            }

            if (m_Order.IsAddressIdNull())
            {
                this.CompleteSaleError1.Visible = true;
                isCompleteSaleInvalid = true;
            }
            else
            {
                this.CompleteSaleError1.Visible = false;
            }

            if (m_Order.IsShippingOptionNull())
            {
                this.CompleteSaleError2.Visible = true;
                isCompleteSaleInvalid = true;
            }
            else
            {
                this.CompleteSaleError2.Visible = false;
            }

            if (m_Order.IsBillingAddressIdNull())
            {
                this.CompleteSaleError3.Visible = true;
                isCompleteSaleInvalid = true;
            }
            else
            {
                this.CompleteSaleError3.Visible = false;
            }

            if (Session["buyerCreditCardType"] == null ||
                        Session["buyerCreditCardCVV2"] == null ||
                        Session["buyerCreditCardExpirationDate"] == null ||
                        Session["buyerCreditCardNumber"] == null)
            {
                this.CompleteSaleError4.Visible = true;
                isCompleteSaleInvalid = true;
            }
            else
            {
                this.CompleteSaleError4.Visible = false;
            }
        }

        protected void ShippingOptions_Load(object sender, EventArgs e)
        {
            if (ShippingRadioButtons.Items.Count == 0 || ReloadShippingOptions)
            {
                if (this.residentialCheckBox.Checked)
                {
                    m_Order.residential = 1;
                    Session["residential"] = 1;
                }
                else
                {
                    m_Order.residential = 0;
                    Session["residential"] = 0;
                }

                decimal freightQuote = 0;

                if (Session["freightQuote"] != null)
                {
                    try
                    {
                        freightQuote = Convert.ToDecimal(Session["freightQuote"]);
                    }
                    catch
                    {
                        freightQuote = 0;
                    }
                }

                ShippingRadioButtons.DataSource = daLayer.GetShippingOptions(m_Order, m_Order.residential, freightQuote);
                ShippingRadioButtons.DataTextField = "OutputString";
                ShippingRadioButtons.DataValueField = "OptionId";
                ShippingRadioButtons.SelectedValue = null;
                ShippingRadioButtons.DataBind();

                if (m_Order.IsShippingOptionNull())
                {
                    if (ShippingRadioButtons.Items.Count > 0)
                    {
                        ShippingRadioButtons.SelectedIndex = 0;
                    }
                }
                else
                {
                    ShippingRadioButtons.SelectedValue = m_Order.ShippingOption.ToString();
                }
            }
        }

        protected void PaymentOptions_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack || reloadBillingAddress)
            {
                BillingState.DataSource = daLayer.GetStates();
                BillingState.DataBind();

                BillingPreviousAddress.DataSource = daLayer.GetPreviousAddresses((int)Session["LoginId"]).Rows;
                BillingPreviousAddress.DataTextField = "TextString";
                BillingPreviousAddress.DataValueField = "cust_addr_id";
                BillingPreviousAddress.DataBind();

                if (!m_Order.IsBillingAddressIdNull())
                {
                    SetBillingAddress(m_Order.BillingAddressId);
                }
            }

            if (CartRow == null)
            {
                Cart = daLayer.GetCart(m_Order.CartId, (int)Session["LoginId"]);
                CartRow = Cart._Cart.FindByCartId(m_Order.CartId);
                this.BillingCartRepeater.DataSource = Cart.CartLine;
                this.BillingCartRepeater.DataBind();
            }

            // TODO:  Is this located in the wrong location?  IsPostback Test?  (Should be up higher in the method?)
            if (!IsPostBack)
            {
                CreditCardExpirationYear.Items.Clear();

                for (int i = DateTime.Now.Year; i < DateTime.Now.Year + 15; ++i)
                {
                    CreditCardExpirationYear.Items.Add(i.ToString());
                }
            }
        }

        protected void ShippingAddress_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack || reloadShippingAddress)
            {
                ShippingState.DataSource = daLayer.GetStates();
                ShippingState.DataBind();

                ShippingPreviousAddress.DataSource = daLayer.GetPreviousAddresses((int)Session["LoginId"]).Rows;
                ShippingPreviousAddress.DataTextField = "TextString";
                ShippingPreviousAddress.DataValueField = "cust_addr_id";
                ShippingPreviousAddress.DataBind();

                if (!m_Order.IsAddressIdNull())
                {
                    SetShippingAddress(m_Order.AddressId);
                }
            }

            reloadShippingAddress = false;
        }


        private void SetShippingAddress(int id)
        {
            ShippingPreviousAddress.SelectedValue = id.ToString();
            ShipPrevAddress_Change(null, null);
        }


        private void SetBillingAddress(int id)
        {
            BillingPreviousAddress.SelectedValue = id.ToString();
            BillPrevAddress_Change(null, null);
        }

        protected void CompleteSaleError_Click(object sender, EventArgs e)
        {
            if (sender.Equals(CompleteSaleError1))
            {
                this.CheckoutWizard.ActiveStepIndex = 0;
            }
            else if (sender.Equals(CompleteSaleError2))
            {
                this.CheckoutWizard.ActiveStepIndex = 1;
            }
            else if (sender.Equals(CompleteSaleError3) || sender.Equals(CompleteSaleError4))
            {
                this.CheckoutWizard.ActiveStepIndex = 2;
            }
        }

        protected void NextButton_Click(object sender, WizardNavigationEventArgs e)
        {
            string paymentAmount;
            string buyerLastName;
            string buyerFirstNAme;

            string buyerAddress1;
            string buyerAddress2;
            string buyerCity;
            string buyerState;
            string buyerCountry;
            string buyerZipCode;

            string buyerCreditCardType;
            string buyerCreditCardNumber;
            string buyerCreditCardCVV2;
            int buyerCreditCardExpirationMonth;
            int buyerCreditCardExpirationYear;

            string referralCode;

            if (Page.IsValid && (e.CurrentStepIndex != 3 || !isCompleteSaleInvalid))
            {
                if (m_Order == null)
                {
                    // Get order from Session
                    m_Order = daLayer.GetOrderByOrderID((int)Session["OrderID"]);
                }

                switch (e.CurrentStepIndex)
                {
                    case 0://Shopping Cart

                        if (ShippingPreviousAddress.SelectedIndex == 0)//meaning a blank address, so use the top values
                        {

                            if (((CheckoutTables)m_Order.Table.DataSet).Address.FindBycust_addr_id(-1) != null)
                            {
                                ((CheckoutTables)m_Order.Table.DataSet).Address.RemoveAddressRow(((CheckoutTables)m_Order.Table.DataSet).Address.FindBycust_addr_id(-1));
                            }

                            ((CheckoutTables)m_Order.Table.DataSet).Address.AddAddressRow(-1, (int)Session["LoginId"],
                                ShippingAddress1.Text.Trim(), ShippingAddress2.Text.Trim(), ShippingState.SelectedValue.Trim(),
                                dataScrubber.CleanPhoneNumber(ShippingPhone.Text.Trim()), dataScrubber.CleanPhoneNumber(ShippingFax.Text.Trim()), 
                                ShippingZipCode.Text.Trim(), ShippingCity.Text.Trim(),
                                ShippingLastName.Text.Trim(), ShippingFirstName.Text.Trim());

                            m_Order.AddressId = -1;

                            reloadShippingAddress = true;
                        }
                        else
                        {
                            m_Order.AddressId = Int32.Parse(ShippingPreviousAddress.SelectedValue);
                        }

                        Session["freightQuote"] = freightGiven.Text.Trim();

                        CompleteSaleError1.Visible = false;
                        m_Order.Status = '1';
                        ReloadShippingOptions = true;
                        reloadBillingAddress = true;

                        break;

                    case 1://Shipping Selection

                        m_Order.Status = '2';

                        //TODO: unhandled exception happens here

                        m_Order.ShippingOption = Int32.Parse(ShippingRadioButtons.SelectedValue);
                        CompleteSaleError2.Visible = false;

                        break;

                    case 2://Payment Selection

                        if (BillingPreviousAddress.SelectedIndex == 0)//meaning a blank address
                        {
                            if (((CheckoutTables)m_Order.Table.DataSet).Address.FindBycust_addr_id(-2) != null)//remove the one in the dataset that is for 'dummy' situations
                            {
                                ((CheckoutTables)m_Order.Table.DataSet).Address.RemoveAddressRow(((CheckoutTables)m_Order.Table.DataSet).Address.FindBycust_addr_id(-2));
                            }

                            // TODO:  What is this -2 business?
                            ((CheckoutTables)m_Order.Table.DataSet).Address.AddAddressRow(-2, (int)Session["LoginId"],
                                BillingAddress1.Text.Trim(), BillingAddress2.Text.Trim(), BillingState.SelectedValue.Trim(),
                                dataScrubber.CleanPhoneNumber(BillingPhoneNumber.Text.Trim()), dataScrubber.CleanPhoneNumber(BillingFax.Text.Trim()), BillingZipCode.Text.Trim(), BillingCity.Text.Trim(),
                                BillingLastName.Text.Trim(), BillingFirstName.Text.Trim());

                            m_Order.BillingAddressId = -2;
                            reloadBillingAddress = true;
                        }
                        else
                        {
                            m_Order.BillingAddressId = Int32.Parse(BillingPreviousAddress.SelectedValue);
                        }

                        CompleteSaleError3.Visible = false;

                        // Prepare Data for Insert
                        buyerCreditCardType = CreditCardType.SelectedValue;
                        buyerCreditCardCVV2 = CreditCardCVV2.Text.Trim();

                        DateTime buyerCreditCardExpirationDate = new DateTime(Int32.Parse(CreditCardExpirationYear.Text), Int32.Parse(CreditCardExpirationMonth.Text), 1);

                        //sets the CC number as an encrypted value, only to be decrypted when necessary;
                        buyerCreditCardNumber = theEncrypter.Encrypt(Regex.Replace(CreditCardNumber.Text.Trim(), "[^0-9]", ""), buyerCreditCardType, buyerCreditCardCVV2, "MD5", 2, "TGBYHNUJMIKLOPRE", 192);

                        Session["buyerCreditCardType"] = buyerCreditCardType;
                        Session["buyerCreditCardCVV2"] = buyerCreditCardCVV2;
                        Session["buyerCreditCardExpirationDate"] = buyerCreditCardExpirationDate;
                        Session["buyerCreditCardNumber"] = buyerCreditCardNumber;

                        //Steve 11/13/08 adding referral code
                        referralCode = ReferralCode.Text.Trim();
                        Session["ReferralCode"] = referralCode;
                        m_Order.ReferralCode = referralCode;

                        CompleteSaleError4.Visible = false;
                        m_Order.Status = '3';

                        // VERY IMPORTANT - This call saves the order in the database
                        m_Order = daLayer.SaveOrder(m_Order);

                        break;

                    case 3://Summary, order submitted

                        decimal total = (this.CartRow.OrderSubTotal + GetShippingOptionById(m_Order.ShippingOption).Cost + TaxCost);

                        if (total == decimal.Parse(CalculatedTotal.Value))
                        {
                            DataChangedError.Visible = false;

                            PayPalAPI api = new PayPalAPI();

                            // Prepare Data for Paypal Invokation
                            paymentAmount = total.ToString("C");
                            buyerLastName = OrderBillingAddress.cust_lastname.Trim();
                            buyerFirstNAme = OrderBillingAddress.cust_firstname.Trim();

                            buyerAddress1 = OrderBillingAddress.cust_addr_1.Trim();
                            buyerAddress2 = OrderBillingAddress.cust_addr_2.Trim();
                            buyerCity = OrderBillingAddress.cust_city.Trim();
                            buyerState = OrderBillingAddress.cust_state.Trim();
                            buyerZipCode = OrderBillingAddress.cust_zip.Trim();

                            if (buyerState == "AB" || buyerState == "BC" || buyerState == "MB" || buyerState == "NB" || buyerState == "NS" || buyerState == "NT"
                                || buyerState == "NU" || buyerState == "ON" || buyerState == "PE" || buyerState == "QC" || buyerState == "SK" || buyerState == "YT")
                            {
                                buyerCountry = "Canada";
                            }
                            else
                            {
                                buyerCountry = "USA";
                            }

                            buyerCreditCardType = Session["buyerCreditCardType"].ToString();
                            buyerCreditCardCVV2 = Session["buyerCreditCardCVV2"].ToString();
                            buyerCreditCardExpirationMonth = ((DateTime)Session["buyerCreditCardExpirationDate"]).Month;
                            buyerCreditCardExpirationYear = ((DateTime)Session["buyerCreditCardExpirationDate"]).Year;

                            //Decrypt
                            buyerCreditCardNumber = theEncrypter.Decrypt(Session["buyerCreditCardNumber"].ToString(), buyerCreditCardType,
                                buyerCreditCardCVV2, "MD5", 2, "TGBYHNUJMIKLOPRE", 192);

                            PaymentActionCodeType buyerCreditCardActionCode = PaymentActionCodeType.Sale;

                            //Invoke API
                            DoDirectPaymentResponseType response = api.DoDirectPayment(paymentAmount, buyerLastName, buyerFirstNAme, buyerAddress1, buyerAddress2,
                                buyerCity, buyerState, buyerZipCode, buyerCreditCardType, buyerCreditCardNumber, buyerCreditCardCVV2, buyerCreditCardExpirationMonth,
                                buyerCreditCardExpirationYear, buyerCreditCardActionCode, buyerCountry);

                            if (response.Errors == null || response.Errors.Length == 0)
                            {
                                m_Order.Status = 'S';
                                daLayer.SetCartStatus(m_Order.CartId, Enums.CartStatus.Submitted);

                                //be sure to store referral code
                                m_Order.ReferralCode = Session["ReferralCode"].ToString();

                                CheckoutTables.CreditCardInfoRow creditCardRow = (m_Order.IsCreditCardIdNull()) ? null : m_Order.CreditCardInfoRow;
                                m_Order = daLayer.SaveOrder(m_Order);

                                if (creditCardRow != null)
                                {
                                    m_Order.CreditCardId = ((CheckoutTables)m_Order.Table.DataSet).CreditCardInfo.AddCreditCardInfoRow(creditCardRow.CCType,
                                        creditCardRow.CCNumber, creditCardRow.CVV2, creditCardRow.Expires).CCInfoId;
                                }
                                else
                                {
                                    // TODO: What if we get a null creditCardRow? Ask Erich.
                                }

                                Session["OrderID"] = m_Order.OrderId;
                                daLayer.SubmitOrder(m_Order.OrderId, CartRow.OrderSubTotal, this.TaxCost, m_Order.ShippingOption,
                                    GetShippingOptionById(m_Order.ShippingOption).Name, GetShippingOptionById(m_Order.ShippingOption).Cost,
                                    GetShippingOptionById(m_Order.ShippingOption).Cost + CartRow.OrderSubTotal + TaxCost);

                                // added by SG to run the LumberIQ create order SP
                                daLayer.CreateLumberIQOrder(m_Order.OrderId);

                                Response.Redirect("Receipt.aspx?OrderNumber=" + m_Order.OrderId);
                            }
                            else
                            {
                                PaypalError.Visible = true;
                                PaypalError.Text = "While submitting the order, an error occurred with the payment options provided.  Please review the error, fix the cause, and click finish again: ";

                                foreach (ErrorType t in response.Errors)
                                {
                                    PaypalError.Text += t.ErrorCode + ":" + t.LongMessage + " <br/> ";
                                }

                                EventLog.WriteEntry("Website", "Error submitting the error through paypal directpay: " + PaypalError.Text, EventLogEntryType.Error);
                            }
                        }
                        else
                        {
                            DataChangedError.Visible = true;
                        }

                        break;

                    default:
                        throw new Exception("Error occurred - step requested doesn't exist in checkout.aspx. eCurrentStepIndex");
                }

                CheckoutTables.CreditCardInfoRow creditCardRow2 = (m_Order.IsCreditCardIdNull()) ? null : m_Order.CreditCardInfoRow;
                m_Order = daLayer.SaveOrder(m_Order);

                if (creditCardRow2 != null)
                {
                    m_Order.CreditCardId = ((CheckoutTables)m_Order.Table.DataSet).CreditCardInfo.AddCreditCardInfoRow(creditCardRow2.CCType,
                        creditCardRow2.CCNumber, creditCardRow2.CVV2, creditCardRow2.Expires).CCInfoId;
                }

                Session["OrderID"] = m_Order.OrderId;

                if (ReloadShippingOptions)
                {
                    ShippingOptions_Load(null, null);
                }

                if (reloadBillingAddress)
                {
                    PaymentOptions_Load(null, null);
                }

                if (reloadShippingAddress)
                {
                    ShippingAddress_Load(null, null);
                }
            }
            else 
            {
                e.Cancel = true;
            }

            if (reloadShippingAddress)
            {
                ShippingPreviousAddress.DataSource = daLayer.GetPreviousAddresses((int)Session["LoginId"]).Rows;
                ShippingPreviousAddress.DataTextField = "TextString";
                ShippingPreviousAddress.DataValueField = "cust_addr_id";
                ShippingPreviousAddress.DataBind();
                SetShippingAddress(m_Order.AddressId);
            }

            reloadShippingAddress = false;
        }

        protected void CreditCardNumber_Validate(object sender, ServerValidateEventArgs e)
        {

            // TODO:  Move to centralized CLEANING method.
            string CardNumber = Regex.Replace(e.Value, "([^0-9])", "").Trim();

            switch (CreditCardType.SelectedValue)
            {
                case "Amex":
                    //AmEx is 15 numbers, first 2 are 34 or 37
                    if (CardNumber.Length == 15 && CardNumber[0] == '3' && (CardNumber[1] == '4' || CardNumber[1] == '7'))
                    {
                        //card is valid
                    }
                    else
                    {
                        e.IsValid = false;
                        return;
                    }
                    break;
                case "Visa":
                    //Visa is 13 or 16 numbers, and first number is 4
                    if ((CardNumber.Length == 16 || CardNumber.Length == 13) && CardNumber[0] == '4')
                    {
                        //card is valid
                    }
                    else
                    {
                        e.IsValid = false;
                        return;
                    }
                    break;
                case "MasterCard":
                    //Mastercard is 16 numbers, first 2 numbers are 51,52,53,54, or 55
                    if (CardNumber.Length == 16 && CardNumber[0] == '5' && CardNumber[1] >= '1' && CardNumber[1] <= '5')
                    {
                        //card is valid
                    }
                    else
                    {
                        e.IsValid = false;
                        return;
                    }
                    break;
                case "Discover":
                    //Discover is 16 numbers, first 4 are 6011
                    if (CardNumber.Length == 16 && CardNumber.Substring(0, 4) == "6011")
                    {
                        //card is valid
                    }
                    else
                    { 
                        e.IsValid = false;
                        return;
                    }
                    break;
                default:
                    throw new Exception("Invalid Credit Card Type: " + CreditCardType.SelectedValue);
            }

            e.IsValid = ChecksumCreditCardNumber(CardNumber);
        }

        // uses the Luhn Formula to checksum credit card numbers
        private bool ChecksumCreditCardNumber(string Number)
        {
            int doubleTotal = 0;
            //start @ right, take 2nd number in, and every other digit, double, and add all digits
            for (int i = Number.Length - 2; i >= 0; i -= 2)
            {
                int curVal = ((int)(Number[i] - '0')) * 2;

                while (curVal > 0)
                {
                    doubleTotal += curVal % 10;
                    curVal = curVal / 10;
                }
            }

            int otherTotal = 0;

            for (int i = Number.Length - 1; i >= 0; i -= 2)
            {
                otherTotal += ((int)(Number[i] - '0'));
            }

            return (doubleTotal + otherTotal) % 10 == 0;
        }

        protected void ExpressCheckout_Click(object sender, EventArgs e)
        {
            PayPalAPI api = new PayPalAPI();

            SetExpressCheckoutResponseType response = api.SetExpressCheckout(((UiMasterPage)this.Master).CartTotal().ToString("C"), this.Request.Url.ToString().Replace("Checkout.aspx", "ExpressCheckoutReturn.aspx"), this.Request.Url.ToString());

            if (response.Errors == null || response.Errors.Length == 0)
            {
                //store 'token'
                daLayer.SetExpressCheckoutToken(m_Order, response.Token);
                Response.Redirect(System.Configuration.ConfigurationManager.AppSettings["PaypalExpressWebsite"] + response.Token);
            }
            else
            {
                this.ExpressCheckoutErrorMessage.Text = "The following errors occurred attempting Express checkout:" +
                    GetPaypalErrorString(response.Errors);
                this.ExpressCheckoutErrorMessage.Visible = true;

                // TODO:  SERIOUS.  Should raise major error and notify administrator.
                EventLog.WriteEntry("Website", "Error starting express checkout: " + ExpressCheckoutErrorMessage.Text, EventLogEntryType.Error);
            }
        }

        private string GetPaypalErrorString(ErrorType[] errors)
        {
            string str = "";

            foreach (ErrorType et in errors)
            {
                str += et.ErrorCode + ":" + et.ErrorParameters + "    " + et.SeverityCode + "   " + et.ShortMessage + "     " + et.LongMessage + "<br/>";
            }

            return str;
        }

        protected void ShipPrevAddress_Change(object sender, EventArgs e)
        {
            ShippingFirstName.Enabled = (ShippingPreviousAddress.SelectedIndex == 0);
            ShippingFirstNameRequired.Enabled = (ShippingPreviousAddress.SelectedIndex == 0);
            ShippingLastName.Enabled = (ShippingPreviousAddress.SelectedIndex == 0);
            ShippingLastNameRequired.Enabled = (ShippingPreviousAddress.SelectedIndex == 0);
            ShippingAddress1.Enabled = (ShippingPreviousAddress.SelectedIndex == 0);
            ShippingAddress1Required.Enabled = (ShippingPreviousAddress.SelectedIndex == 0);
            ShippingAddress2.Enabled = (ShippingPreviousAddress.SelectedIndex == 0);
            ShippingCity.Enabled = (ShippingPreviousAddress.SelectedIndex == 0);
            ShippingCityRequired.Enabled = (ShippingPreviousAddress.SelectedIndex == 0);
            ShippingFax.Enabled = (ShippingPreviousAddress.SelectedIndex == 0);
            ShippingPhone.Enabled = (ShippingPreviousAddress.SelectedIndex == 0);
            ShippingPhoneRequired.Enabled = (ShippingPreviousAddress.SelectedIndex == 0);
            ShippingState.Enabled = (ShippingPreviousAddress.SelectedIndex == 0);
            ShippingZipCode.Enabled = (ShippingPreviousAddress.SelectedIndex == 0);
            ShippingZipCodeRequired.Enabled = (ShippingPreviousAddress.SelectedIndex == 0);

        }

        protected void BillPrevAddress_Change(object sender, EventArgs e)
        {
            BillingFirstName.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
            BillingFirstNameRequired.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
            BillingLastName.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
            BillingLastNameRequired.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
            BillingAddress1.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
            BillingAddress1Required.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
            BillingAddress2.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
            BillingCity.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
            BillingCityRequired.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
            BillingFax.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
            BillingPhoneNumber.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
            BillingPhoneNumberRequired.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
            BillingState.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
            BillingZipCode.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
            BillingZipCodeRequired.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
        }

        protected ShippingOption GetShippingOptionById(int id)
        {
            decimal freightQuote = 0;

            if (Session["freightQuote"] != null)
            {
                try {
                    freightQuote = Convert.ToDecimal(Session["freightQuote"]);
                }
                catch {
                    freightQuote = 0;
                }
            }

            if (options == null)
            {
                if (Convert.ToInt16(Session["residential"]) == 1)
                {
                    options = daLayer.GetShippingOptions(m_Order, 1, freightQuote);
                }
                {
                    options = daLayer.GetShippingOptions(m_Order, 0, freightQuote);
                }
            }

            foreach (ShippingOption o in options)
            {
                if (o.OptionId == id)
                {
                    return o;
                }
            }
            return null;

        }

        #endregion

        #region Properties

        protected decimal TaxPercent
        {
            get
            {
                // TODO:  Comment Needed.
                if (OrderShippingAddress == null)
                {
                    return 0;
                }
                // TODO:  Comment Needed.
                if (salesTaxPercent < 0)
                {
                    salesTaxPercent = daLayer.GetStateSalesTax(OrderShippingAddress.cust_state, m_Order.CustomerId);
                }
                return salesTaxPercent;
            }
        }

        protected decimal TaxCost
        {
            get
            {
                return CartRow.OrderSubTotal * (TaxPercent / 100);
            }
        }

        protected CheckoutTables.AddressRow OrderBillingAddress
        {
            get
            {
                if (m_Order.IsBillingAddressIdNull())
                {
                    return null;
                }
                else
                {
                    if (prev_addresses == null)
                    {
                        prev_addresses = daLayer.GetPreviousAddresses((int)Session["LoginId"]);
                    }

                    if (prev_addresses == null)
                    {
                        return null;
                    }

                    return prev_addresses.FindBycust_addr_id(m_Order.BillingAddressId);
                }
            }
        }

        protected CheckoutTables.AddressRow OrderShippingAddress
        {
            get
            {
                if (m_Order.IsAddressIdNull())
                {
                    return null;
                }
                else
                {
                    if (prev_addresses == null)
                    {
                        prev_addresses = daLayer.GetPreviousAddresses((int)Session["LoginId"]);
                    }
                    if (prev_addresses == null)
                    {
                        return null;
                    }

                    return prev_addresses.FindBycust_addr_id(m_Order.AddressId);
                }
            }
        }

        protected string CreditCardLastFour
        {
            get
            {
                if (m_Order.IsCreditCardIdNull())
                {
                    return "";
                }
                else
                {
                    //TODO: Move to Business Object
                    string CCNum = theEncrypter.Decrypt(m_Order.CreditCardInfoRow.CCNumber, m_Order.CreditCardInfoRow.CCType, m_Order.CreditCardInfoRow.CVV2, "MD5", 2, "TGBYHNUJMIKLOPRE", 192);
                    return StarOutString(CCNum, 4);
                }
            }
        }

        #endregion

    }
}