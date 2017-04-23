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
using BusinessTier.DataAccessLayer;
using System.Text.RegularExpressions;
using BusinessTier.Utility;
using BusinessTier.Accounts;
using System.Net.Mail;
using System.Text;
using System.IO;

namespace WebUI
{

    public partial class CreateAcct : System.Web.UI.Page
    {
        protected DataAccessLayer daLayer = new DataAccessLayer();
        protected DataScrubber dataScrubber = new DataScrubber();

        protected void Page_Load(object sender, EventArgs e)
        {
            // It is time to enter HTTPS mode and stay there for the remainder of the session.
            if ((!Request.IsSecureConnection) & (System.Configuration.ConfigurationManager.AppSettings["https-mode"] == "yes"))
            {
                Response.Redirect(Request.Url.AbsoluteUri.Replace("http://", "https://"), false);
                return;
            }

            // The login page grabs details, and then upon success, re-directs you to the page you came from.
            // In order to redirect you, we save the Referrer.Value
            if (Request["Referrer"] != null)
            {
                Referrer.Value = Request["Referrer"].ToString();
            }
            else
            {
                // TODO:  REFACTOR.  Consider raising an exception here.
            }

            if (!IsPostBack)
            {
                //reset the cookies
                Session["LoginId"] = null;
                Session["CustName"] = null;
                Session["Discount"] = null;

                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "forest");
            }
        }

        protected void CreateAccount_Click(object sender, EventArgs e)
        {
            // Get a RegEx to test the email against.
            DataScrubber theDataScrubber = new DataScrubber();
            Regex emailTestRegEx = theDataScrubber.GenerateEmailRegEx();

            string productsList = "";
            string speciesList = "";
            string servicesList = "";
            int CreateAccountResult = 0;

            foreach (ListItem lstItem in CreateProductCategory.Items)
            {
                if (lstItem.Selected == true)
                {
                    if (productsList.Length > 2)
                    {
                        productsList += ", " + lstItem.Text;
                    }
                    else
                    {
                        productsList = lstItem.Text;
                    }
                }
            }

            foreach (ListItem lstItem in CreateSpeciesList.Items)
            {
                if (lstItem.Selected == true)
                {
                    if (speciesList.Length > 2)
                    {
                        speciesList += ", " + lstItem.Text;
                    }
                    else
                    {
                        speciesList = lstItem.Text;
                    }
                }
            }

            foreach (ListItem lstItem in CreateServicesList.Items)
            {
                if (lstItem.Selected == true)
                {
                    if (servicesList.Length > 2)
                    {
                        servicesList += ", " + lstItem.Text;
                    }
                    else
                    {
                        servicesList = lstItem.Text;
                    }
                }
            }

            // Test for stupid people, spam, etc. 
            if (CreateEmail.Text.Trim().Contains(".cn") || CreateEmail.Text.Trim().Contains(".ru") || CreateZIP.Text.Trim().Length < 5 || CreateState.Text.Trim().Length < 2
                || CreateAddress1.Text.Trim().Length < 8 || CreateCity.Text.Trim().Length < 5)
            {
                CustomValidatorCreateAccount.IsValid = false;
                CustomValidatorCreateAccount.ErrorMessage = "Account registration failed to meet our policies.";
                return;
            }

            // Validate fields are not empty and that the account was created.
            if (!String.IsNullOrEmpty(CreateEmail.Text.Trim()) &&
                emailTestRegEx.IsMatch(CreateEmail.Text.Trim()) &&
                (CreateAccountResult = daLayer.CreateAccount(CreateReference.Text.Trim(), CreateEmail.Text.Trim(), CreatePassword.Text.Trim(),
                    CreateCompanyName.Text.Trim(), CreateAddress1.Text.Trim(), CreateAddress2.Text.Trim(),
                    CreateCity.Text.Trim(), CreateState.Text.Trim(), CreateZIP.Text.Trim(),
                    CreateCountry.Text.Trim(), dataScrubber.CleanPhoneNumber(CreatePhone.Text.Trim()), dataScrubber.CleanPhoneNumber(CreateFAX.Text.Trim()),
                    CreateReceiveEmails.Checked, CreateAccountType.SelectedValue,
                    CreateFirstName.Text.Trim(), CreateLastName.Text.Trim(),
                    productsList, speciesList, servicesList, CreateTagline.Text.Trim(),
                    CreateAbout.Text.Trim(), CreateWebsite.Text.Trim()
                    )) > 0
                )
            {
                // Send email if new acct successful

                Session["LoginId"] = CreateAccountResult;

                // Send email if new acct successful

                // Declare stringbuilder to render control to
                StringBuilder sb = new StringBuilder();

                // Load the control
                UserControl ctrl = (UserControl)LoadControl("~/Controls/email-welcome.ascx");

                // Do stuff with ctrl here


                // Render the control into the stringbuilder
                StringWriter sw = new StringWriter(sb);
                Html32TextWriter htw = new Html32TextWriter(sw);
                ctrl.RenderControl(htw);

                // Get full body text
                string body = sb.ToString();

                body = body.Replace("PP", productsList + "<br/>" + speciesList + "<br/>" + servicesList + "<br/><br/>" +
                    CreateFirstName.Text.Trim() + " " + CreateLastName.Text.Trim() + "<br/>" +
                    CreateCompanyName.Text.Trim() + "<br/>" + CreateAddress1.Text.Trim() + "<br/>" + CreateAddress2.Text.Trim() + "<br/>" +
                    CreateCity.Text.Trim() + ", " + CreateState.Text.Trim() + "  " + CreateZIP.Text.Trim() + "<br/>" +
                    CreateCountry.Text.Trim() + "<br/>" + dataScrubber.CleanPhoneNumber(CreatePhone.Text.Trim()));

                // TODO: maybe add the type of customer and their comments as well to the body - same section is fine

                MailMessage message = new MailMessage();
                message.To.Add(CreateEmail.Text.Trim());
                message.From = new MailAddress(System.Configuration.ConfigurationManager.AppSettings["EmailFromAddress"]);
                message.Subject = "Nova USA Wood Products - Thanks for signing up.";
                // message.CC.Add(System.Configuration.ConfigurationManager.AppSettings["EmailFromAddress"]);
                message.Bcc.Add("steve@novausawood.com, bill@novausawood.com, john@novausawood.com");
                message.IsBodyHtml = true;

                message.Body = body;

                SmtpClient client = new SmtpClient();

                client.Host = System.Configuration.ConfigurationManager.AppSettings["SMTPServer"];
                client.EnableSsl = false;
                client.Port = 587;
                client.UseDefaultCredentials = false;

                client.Credentials = new System.Net.NetworkCredential(System.Configuration.ConfigurationManager.AppSettings["EmailFromUserName"],
                    System.Configuration.ConfigurationManager.AppSettings["EmailFromPassword"]);

                //client.DeliveryMethod = SmtpDeliveryMethod.SpecifiedPickupDirectory;
                //client.PickupDirectoryLocation = "C:\\inetpub\\mailroot\\Pickup";
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.Send(message);

                Response.Redirect("thank-you.aspx");

            }
            else if (CreateAccountResult == (int)Enums.CreateAccountErrorMessages.EmailTaken)
            {
                CustomValidatorCreateAccount.IsValid = false;
                CustomValidatorCreateAccount.ErrorMessage = "The email address you entered is already in use by another account. Every registration must have a unique email address.";
            }
            else if (CreateAccountResult == (int)Enums.CreateAccountErrorMessages.OtherError)
            {
                CustomValidatorCreateAccount.IsValid = false;
                CustomValidatorCreateAccount.ErrorMessage = "Sorry, an unexpected error has occurred!";
            }
        }
    }
}