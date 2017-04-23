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
using BusinessTier.Utility;

namespace WebUI
{
    public partial class Account : System.Web.UI.Page
    {
        protected DataAccessLayer daLayer = new DataAccessLayer();
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((!Request.IsSecureConnection) & (System.Configuration.ConfigurationManager.AppSettings["https-mode"] == "yes"))
            {
                Response.Redirect(Request.Url.AbsoluteUri.Replace("http://", "https://"), false);
                return;
            }
            if (Session["LoginId"] == null)
            {
                Response.Redirect("Login.aspx?Referrer=Account.aspx", false);
            }
            if (!IsPostBack)
            {
                BusinessTier.DataAccessLayer.customer.customerDataTable customerData = daLayer.GetCustomer((int)Session["LoginId"]);

                if (customerData.Count == 0 || customerData[0].Isemail_addressNull())
                {
                    Response.Redirect("Login.aspx?Referrer=Account.aspx", false);
                }

                FirstName.Text = (customerData[0].Isfirst_nameNull()) ? "" : customerData[0].first_name.Trim();
                LastName.Text = (customerData[0].Islast_nameNull()) ? "" : customerData[0].last_name.Trim();
                CompanyName.Text = customerData[0].cust_name.Trim();
                EmailAddress.Text = customerData[0].email_address.Trim();
                ReceiveEmails.Checked = customerData[0].receive_email;

            }
        }

        protected void SaveCustomerChanges_Click(object sender, EventArgs e)
        {
            int result = daLayer.UpdateAccount((int)Session["LoginId"], EmailAddress.Text.Trim(), CompanyName.Text.Trim(),
                FirstName.Text.Trim(), LastName.Text.Trim(), ReceiveEmails.Checked);
            if (result == (int)Enums.CreateAccountErrorMessages.EmailTaken)
            {
                CustomValidatorUpdateAccount.IsValid = false;
                CustomValidatorUpdateAccount.ErrorMessage = "The email address you entered is already in use by another user.";
                StatusLabel.Visible = false;
            }
            else
            {
                StatusLabel.Visible = true;
            }
        }
    }
}
