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
    public partial class ipe_decking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            /*
            masterPage.SetMetaTags(
                "Ipe Decking | Ipe Hardwood Decks | Ipe Exterior Decking",
                "Specializing in Ipe Decking, Ipe Hardwood Decking, Exotic, Brazilian Walnut, Prefinished and Unfinished Solid Ipe Hardwood, Engineered Ipe Flooring. Certified, FSC, IBAMA, Green.",
                "ipe hardwood decking, ipe deck material");
            */

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "ipe-deck");
            }

        }
    }
}
