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
    public partial class KD_Ipe_Decking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Ipe KD Decking | Kiln Dried Ipe Hardwood Decks | Nova USA",
                "Specializing in Kiln Dried Ipe Decking, Ipe KD Hardwood Decking, Exotic, Brazilian Walnut, Prefinished and Unfinished Solid Ipe Hardwood, Engineered Ipe Flooring. Certified, FSC, IBAMA, Green.",
                "kiln dried, kd, tropical, ipe, ipe hardwood, ipe flooring, ipe floor, ipe deck, ipe decking, prefinished, unfinished, ipe wood, solid, engineered, exotic, cheap, discount, walnut, lapacho, specializing, certified, green, fsc");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "ipe-deck");
            }

        }
    }
}
