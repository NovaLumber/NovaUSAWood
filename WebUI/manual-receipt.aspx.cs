using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace WebUI
{
    public partial class manual_receipt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            manualPmtLabel.Text = "Transaction ID: "+ Session["transactionID"];

            manualPmtAmount.Text = "Amount Processed: US$" + Session["manualPaymentAmount"];

            buyerLabel1.Text = Session["buyerFirstName"].ToString();
            buyerLabel2.Text = Session["buyerLastName"].ToString();
            buyerLabel3.Text = Session["buyerAddress1"].ToString();
            buyerLabel4.Text = Session["buyerAddress2"].ToString();
            buyerLabel5.Text = Session["buyerCity"].ToString() + ", " + Session["buyerState"].ToString() + " " + Session["buyerZip"].ToString();
        }
    }
}
