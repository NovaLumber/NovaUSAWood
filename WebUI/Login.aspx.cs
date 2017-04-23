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
    public partial class Login : System.Web.UI.Page
    {
        protected customer.customerDataTable CustomerTable;
        protected DataAccessLayer daLayer = new DataAccessLayer();

        #region Methods

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //reset the cookies the first time the page is opened but not on postback
                Session["LoginId"] = null;
                Session["CustName"] = null;
                Session["Discount"] = null;
            }

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
                Referrer.Value = "default.aspx";
            }

        }

        protected void ForgotPasswordButton_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Username.Text.Trim()))
            {

                string tempPassword = String.Empty;
                {//generate random password as first 6 chars of a base64 encoded random byte array
                    Random r = new Random();
                    byte[] tempPasswordBytes = new byte[20];
                    r.NextBytes(tempPasswordBytes);

                    string tmp = System.Convert.ToBase64String(tempPasswordBytes).ToLower();

                    for (int i = 0; i < tmp.Length && tempPassword.Length < 6; ++i)
                    {
                        if (tmp[i] >= 'a' && tmp[i] <= 'z')
                            tempPassword += tmp[i];
                    }
                }

                CustomValidatorLogin.IsValid = daLayer.ForgotPassword(Username.Text.Trim(), tempPassword);

                if (CustomValidatorLogin.IsValid)
                {
                    SmtpClient client = new SmtpClient(System.Configuration.ConfigurationManager.AppSettings["SMTPServer"],
                        Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["SMTPPort"]));

                    client.Credentials = new System.Net.NetworkCredential(System.Configuration.ConfigurationManager.AppSettings["EmailFromUserName"],
                        System.Configuration.ConfigurationManager.AppSettings["EmailFromPassword"]);

                    MailMessage message = new MailMessage(System.Configuration.ConfigurationManager.AppSettings["EmailFromAddress"],
                        Username.Text.Trim(), System.Configuration.ConfigurationManager.AppSettings["ForgotPasswordSubject"],
                        System.Configuration.ConfigurationManager.AppSettings["ForgotPasswordMessage"].Replace("%NEWPASSWORD%", tempPassword));

                    client.DeliveryMethod = SmtpDeliveryMethod.Network;
                    client.Send(message);

                    CustomValidatorLogin.IsValid = false;
                    CustomValidatorLogin.ErrorMessage = "Password reset - please check your email.";
                }
                else
                {
                    CustomValidatorLogin.ErrorMessage = "Email address is invalid";
                }

            }
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {

            // Verify that required field have been entered.  
            if (string.IsNullOrEmpty(Username.Text.Trim()) && string.IsNullOrEmpty(Password.Text.Trim()))
            {
                // Verification failed.
                CustomValidatorLogin.IsValid = false;
                CustomValidatorLogin.ErrorMessage = "You must provide an email address and password to log in";

            }
            else
            {
                // Required Field Verification passed.  Now try to login.

                // Hit the DB and see if this user can log in.
                int? id = daLayer.LoginRegisteredUser(this.Username.Text.Trim(), this.Password.Text.Trim());

                // If the login succeeded
                if (id != null)
                {
                    Session["LoginId"] = id.Value;
                    Session["myTest"] = id.Value;
                    Session["email"] = this.Username.Text.Trim();
                    
                    Response.Redirect(Referrer.Value, false);
                }
                else
                {
                    // The login failed.
                    CustomValidatorLogin.IsValid = false;
                    CustomValidatorLogin.ErrorMessage = "Incorrect email address or password";
                }
            }
        }

        #endregion
    }
}
