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
using System.Text.RegularExpressions;

namespace WebUI
{
    public partial class where_to_buy_nova_flooring : System.Web.UI.Page
    {
        protected Registrations.registered_usersDataTable RegisteredUsersTable;
        protected Registrations.registered_usersRow RegisteredUsersRow;
        protected DataAccessLayer daLayer = new DataAccessLayer();

        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Where to Buy Flooring | Retailers and Dealers | Nova Hardwood Flooring",
                "Need help finding a flooring retailer or dealer with experience specifying Nova Wood Flooring? See our directory listings.",
                "help, finding, retailer, dealer, experience, hardwood, wood, buy, where, flooring, Nova, directory, listing");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "child");
            }

        }

        protected void retrieve_Click(object sender, EventArgs e)
        {
            HtmlControl div = this.Master.FindControl("body") as HtmlControl;
            div.Attributes.Add("class", "child");

            RecordRepeater.DataSource = daLayer.GetRegistrationRecords(4, CleanInput(city.Text), CleanInput(state.Text), CleanInput(zip.Text), "%flooring%", CleanInput(Species.Text)).Rows;
            RecordRepeater.DataBind();
        }

        String CleanInput(string strIn) // Declare Scope
        {
            // Replace invalid characters with empty strings.
            return Regex.Replace(strIn, @"[^\w\-]", "");
        }
    }
}
