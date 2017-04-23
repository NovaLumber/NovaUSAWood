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


namespace WebUI.Controls
{
    public partial class email_signup : System.Web.UI.UserControl
    {

        protected DataAccessLayer daLayer = new DataAccessLayer();
        protected DataScrubber dataScrubber = new DataScrubber();


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SignUp_Click(object sender, EventArgs e)
        {
            // Get a RegEx to test the email against.
            DataScrubber theDataScrubber = new DataScrubber();
            Regex emailTestRegEx = theDataScrubber.GenerateEmailRegEx();

            int CreateAccountResult = 0;

            string interests = "";
            string ip_address = "";

            if (decking.Checked) { interests = interests + "decking "; }
            if (flooring.Checked) { interests = interests + "flooring "; }
            if (kilnsticks.Checked) { interests = interests + "kiln sticks "; }
            if (truckflooring.Checked) { interests = interests + "truck flooring "; }

            //ip_address = HttpContext.Current.Request.UserHostAddress.Trim();
            ip_address = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] ?? HttpContext.Current.Request.UserHostAddress;

            // Test for stupid people, spam, etc. 
            if (email.Text.Trim().Contains(".cn") || email.Text.Trim().Contains(".cn") || email.Text.Trim().Contains("163"))
            {
                return;
            }

            if (!String.IsNullOrEmpty(email.Text.Trim()) &&
                emailTestRegEx.IsMatch(email.Text.Trim()) &&
                (CreateAccountResult = daLayer.RegisterEmail(email.Text.Trim(), zipcode.Text.Trim(), interests.Trim(), ip_address.Trim())) > 0
                )
            {
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
            
                body = body.Replace("PP", interests);

                MailMessage message = new MailMessage();
                message.To.Add(email.Text.Trim());
                message.From = new MailAddress(System.Configuration.ConfigurationManager.AppSettings["EmailFromAddress"]);
                message.Subject = "Nova USA Wood Products - Thanks for signing up.";
                // message.CC.Add(System.Configuration.ConfigurationManager.AppSettings["EmailFromAddress"]);
                // message.Bcc.Add("steve@novausawood.com");
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
                //CustomValidatorCreateAccount.IsValid = false;
                //CustomValidatorCreateAccount.ErrorMessage = "The email address you entered is already in use by another account. Every registration must have a unique email address.";
            }
            else if (CreateAccountResult == (int)Enums.CreateAccountErrorMessages.OtherError)
            {
                //CustomValidatorCreateAccount.IsValid = false;
                //CustomValidatorCreateAccount.ErrorMessage = "Sorry, an unexpected error has occurred!";
            }
        }

    }
}
