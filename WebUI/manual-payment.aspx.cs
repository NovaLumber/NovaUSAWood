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
    public partial class manual_payment : System.Web.UI.Page
    {
        protected Encryption theEncrypter = new Encryption();
        protected DataAccessLayer daLayer = new DataAccessLayer();
        protected DataScrubber dataScrubber = new DataScrubber();
        protected customer.cust_addressDataTable myAddress;

        protected override void OnLoad(EventArgs e)
        {
            
            base.OnLoad(e);

            //test the stored session variables
            int test1, test2;
            test1 = Convert.ToInt16(Session["LoginId"]);
            test2 = Convert.ToInt16(Session["myTest"]);

            // It is time to enter HTTPS mode and stay there for the remainder of the session.
            if ((!Request.IsSecureConnection) & (System.Configuration.ConfigurationManager.AppSettings["https-mode"] == "yes"))
            {
                Response.Redirect(Request.Url.AbsoluteUri.Replace("http://", "https://"), false);
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
                Response.Redirect("Login.aspx?Referrer=manual-payment.aspx", false);                
            }
            else
            {
                PaymentOptions_Load(null, null);
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

        private string GetPaypalErrorString(ErrorType[] errors)
        {
            string str = "";

            foreach (ErrorType et in errors)
            {
                str += et.ErrorCode + ":" + et.ErrorParameters + "    " + et.SeverityCode + "   " + et.ShortMessage + "     " + et.LongMessage + "<br/>";
            }

            return str;
        }

        protected void BillPrevAddress_Change(object sender, EventArgs e)
        {
            Int32 myAddrID;

            /*BillingFirstName.Enabled = (BillingPreviousAddress.SelectedIndex == 0);
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
            BillingZipCodeRequired.Enabled = (BillingPreviousAddress.SelectedIndex == 0);*/

            //possibly set the field data here.
            myAddrID = Int32.Parse(BillingPreviousAddress.SelectedValue);

            myAddress = daLayer.GetCustAddr(myAddrID);

            BillingFirstName.Text = myAddress.FindBycust_addr_id(myAddrID).cust_firstname.Trim();
            BillingLastName.Text = myAddress.FindBycust_addr_id(myAddrID).cust_lastname.Trim();
            BillingAddress1.Text = myAddress.FindBycust_addr_id(myAddrID).cust_addr_1.Trim();
            BillingAddress2.Text = myAddress.FindBycust_addr_id(myAddrID).cust_addr_2.Trim();
            BillingCity.Text = myAddress.FindBycust_addr_id(myAddrID).cust_city.Trim();
            BillingState.Text = myAddress.FindBycust_addr_id(myAddrID).cust_state.Trim();
            BillingZipCode.Text = myAddress.FindBycust_addr_id(myAddrID).cust_zip.Trim();
            BillingPhoneNumber.Text = myAddress.FindBycust_addr_id(myAddrID).cust_phone.Trim();
            BillingFax.Text = myAddress.FindBycust_addr_id(myAddrID).cust_fax.Trim();

        }

        protected void PaymentOptions_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                BillingState.DataSource = daLayer.GetStates();
                BillingState.DataBind();

                BillingPreviousAddress.DataSource = daLayer.GetPreviousAddresses((int)Session["LoginId"]).Rows;
                BillingPreviousAddress.DataTextField = "TextString";
                BillingPreviousAddress.DataValueField = "cust_addr_id";
                BillingPreviousAddress.DataBind();
            }

            /*
            if (!IsPostBack)
            {
                CreditCardExpirationYear.Items.Clear();

                for (int i = DateTime.Now.Year; i < DateTime.Now.Year + 15; ++i)
                {
                    CreditCardExpirationYear.Items.Add(i.ToString());
                }
            }
            */
        }

        protected void processPayment_Click(object sender, EventArgs e)
        {
            string paymentAmount;
            string buyerLastName;
            string buyerFirstName;

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

            //get this from the window and store in session variable
            decimal total = Convert.ToDecimal(Amount.Text.ToString());
            Session["manualPaymentAmount"] = total.ToString();

            // Prepare Data for Insert
            buyerCreditCardType = CreditCardType.SelectedValue;
            buyerCreditCardCVV2 = CreditCardCVV2.Text.Trim();

            buyerCreditCardExpirationMonth = Int32.Parse(CreditCardExpirationMonth.Text);
            buyerCreditCardExpirationYear = Int32.Parse(CreditCardExpirationYear.Text);

            DateTime buyerCreditCardExpirationDate = new DateTime(buyerCreditCardExpirationYear, buyerCreditCardExpirationMonth, 1);

            //sets the CC number as an encrypted value, only to be decrypted when necessary;
            buyerCreditCardNumber = theEncrypter.Encrypt(Regex.Replace(CreditCardNumber.Text.Trim(), "[^0-9]", ""), buyerCreditCardType, buyerCreditCardCVV2, "MD5", 2, "TGBYHNUJMIKLOPRE", 192);

            Session["buyerCreditCardType"] = buyerCreditCardType;
            Session["buyerCreditCardCVV2"] = buyerCreditCardCVV2;
            Session["buyerCreditCardExpirationDate"] = buyerCreditCardExpirationDate;
            Session["buyerCreditCardNumber"] = buyerCreditCardNumber;

            PayPalAPI api = new PayPalAPI();

            // Prepare Data for Paypal Invokation
            paymentAmount = total.ToString("C");

            buyerFirstName = BillingFirstName.Text.ToString() + " " + BillingLastName.Text.ToString();
            buyerLastName = "(Manual Pmt " + ReferralCode.Text.Trim() + ")";

            buyerAddress1 = BillingAddress1.Text.ToString();
            buyerAddress2 = BillingAddress2.Text.ToString();
            buyerCity = BillingCity.Text.ToString();
            buyerState = BillingState.Text.ToString();
            buyerZipCode = BillingZipCode.Text.ToString();

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

            Session["buyerFirstName"] = buyerFirstName;
            Session["buyerLastName"] = buyerLastName;
            Session["buyerAddress1"] = buyerAddress1;
            Session["buyerAddress2"] = buyerAddress2;
            Session["buyerCity"] = buyerCity;
            Session["buyerState"] = buyerState;
            Session["buyerZip"] = buyerZipCode;

            //Decrypt
            buyerCreditCardNumber = theEncrypter.Decrypt(Session["buyerCreditCardNumber"].ToString(), buyerCreditCardType,
                buyerCreditCardCVV2, "MD5", 2, "TGBYHNUJMIKLOPRE", 192);

            PaymentActionCodeType buyerCreditCardActionCode = PaymentActionCodeType.Sale;

            //Invoke API
            DoDirectPaymentResponseType response = api.DoDirectPayment(paymentAmount, buyerLastName, buyerFirstName, buyerAddress1, buyerAddress2,
                buyerCity, buyerState, buyerZipCode, buyerCreditCardType, buyerCreditCardNumber, buyerCreditCardCVV2, buyerCreditCardExpirationMonth,
                buyerCreditCardExpirationYear, buyerCreditCardActionCode, buyerCountry);

            if (response.Errors == null || response.Errors.Length == 0)
            {
                Session["transactionID"] = response.TransactionID;
                Response.Redirect("manual-receipt.aspx");
            }
            else
            {
                PaypalError.Visible = true;
                PaypalError.Text = "While submitting the order, an error occurred with the payment options provided.  Please review the error, fix the cause, and click finish again: ";

                foreach (ErrorType t in response.Errors)
                {
                    PaypalError.Text += t.ErrorCode + ":" + t.LongMessage + " <br/> ";
                }
            }

        }
    }
}
