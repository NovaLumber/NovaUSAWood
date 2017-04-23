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

namespace WebUI
{
    public partial class meranti_decking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            /*
            masterPage.SetMetaTags(
                "Batu Decking, Red Balau Hardwood Decks, Meranti Batu Exterior Decking",
                "The leading hardwood supplier of Meranti Batu hardwood decking & Red Balau decking material. Direct importer of Nova Batu exterior hardwood.",
                "Batu Hardwood Decking, Red Balau Exterior Deck Material, Hardwood Decking Supplier, Batu Decking Supplier");
            */

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "batu-house");
            }
        }
    }
}
