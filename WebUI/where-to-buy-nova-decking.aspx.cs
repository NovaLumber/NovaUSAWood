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
    public partial class where_to_buy_nova_decking : System.Web.UI.Page
    {
        protected Registrations.registered_usersDataTable RegisteredUsersTable;
        protected Registrations.registered_usersRow RegisteredUsersRow;
        protected DataAccessLayer daLayer = new DataAccessLayer();

        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Where to Buy Decking | Retailers and Dealers | Nova Hardwood Decking",
                "Need help finding a decking retailer or dealer with experience specifying Nova Tropical Hardwood Decking? See our directory listings.",
                "help, finding, retailer, dealer, experience, hardwood, tropical, buy, where, decking, Nova, directory, listing");

            HtmlControl div = this.Master.FindControl("body") as HtmlControl;
            div.Attributes.Add("class", "deck");

        }

        protected void retrieve_Click(object sender, EventArgs e)
        {
            RecordRepeater.DataSource = daLayer.GetRegistrationRecords(4, CleanInput(city.Text), CleanInput(state.Text), CleanInput(zip.Text), "%decking%", CleanInput(Species.Text)).Rows;
            RecordRepeater.DataBind();
        }

        String CleanInput(string strIn) // Declare Scope
        {
            // Replace invalid characters with empty strings.
            return Regex.Replace(strIn, @"[^\w\-]", "");
        }
    }
}
