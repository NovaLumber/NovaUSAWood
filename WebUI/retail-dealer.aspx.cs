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
using BusinessTier.DataAccessLayer;

namespace WebUI
{
    public partial class retail_dealer : System.Web.UI.Page
    {
        protected Registrations.registered_usersRow MyDealer;
        protected DataAccessLayer daLayer = new DataAccessLayer();

        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            int dealerID;
            Registrations.registered_usersDataTable result;
            if (Int32.TryParse(Page.Request["ID"], out dealerID) && (result = daLayer.GetCompanyDetails(dealerID)) != null
                && result.Rows.Count > 0)
            {
                MyDealer = result.FindByuser_id(dealerID);
            }
            else
            {
                //Response.Redirect("where-to-buy-flooring.aspx", false);
            }


            masterPage.SetMetaTags(
                MyDealer.company_name+" "+MyDealer.city+" "+MyDealer.state+ " | Retail Dealer | Nova wood products",
                MyDealer.company_name + " " + MyDealer.city + " " + MyDealer.state + " for professional help with Nova products:" + MyDealer.products+", "+MyDealer.services+", "+MyDealer.species,
                MyDealer.company_name + ", " + MyDealer.city + ", " + MyDealer.state + ", help, retailer, dealer, experience, hardwood, wood, buy, where, Nova, " + MyDealer.products + ", " + MyDealer.services + ", " + MyDealer.species);

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "batu-house");
            }
        }

    }
}
