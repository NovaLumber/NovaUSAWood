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
    public partial class cambara_decking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Cambara Mahogany Decking | Cambara Hardwood Decks | Cambara Exterior Decking | Nova USA",
                "Specializing in Cambara Decking, Cambara Hardwood Decking, Mahogany, Exotic, Brazilian Mahogany, Flooring, S4S, E4E, Pattern 132. Certified, IBAMA, Green.",
                "tropical, Cambara, Mahogany, Cambara hardwood, Cambara flooring, Cambara floor, Cambara deck, Cambara decking, prefinished, unfinished, Cambara wood, solid, exotic, cheap, discount, specializing, certified, green, fsc");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "forest");
            }

        }
    }
}
