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
    public partial class garapa_decking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Garapa Decking | Garapa Hardwood Decks | Garapa Exterior Decking | Nova USA",
                "Specializing in Garapa Decking, Garapa Hardwood Decking, Exotic, Brazilian Garapa, Prefinished and Unfinished Solid Garapa Hardwood, Engineered Garapa Flooring. Certified, FSC, IBAMA, Green.",
                "tropical, Garapa, Garapa hardwood, Garapa flooring, Garapa floor, Garapa deck, Garapa decking, prefinished, unfinished, Garapa wood, solid, engineered, exotic, cheap, discount, gold, specializing, certified, green, fsc");

        }
    }
}
