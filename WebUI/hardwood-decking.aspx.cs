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
    public partial class hardwood_decking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            /*
            masterPage.SetMetaTags(
                "Exotic Hardwood Decking | Tropical Hardwood Decks | Hardwood Exterior Decking | Nova USA",
                "Exotic Hardwood Decking: Exterior decking, Ipe decking, Cumaru decking, TigerWood decking, Cambara Mahogany decking, Massaranduba decking, Garapa decking, Meranti decking.",
                "exotic hardwood decking, exterior decking, Ipe decking, Cumaru decking, TigerWood decking, Cambara Mahogany decking, Brazilian Redwood Massaranduba decking, Garapa decking, Meranti decking");
            */

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "tube-boy");
            }

        }
    }
}

