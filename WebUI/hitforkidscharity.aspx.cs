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
    public partial class hitforkids : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Nova USA Wood Products - Charity",
                "Specializing in Prefinished, Unfinished Solid Hardwood, Engineered Flooring and Decking - Exotic, Brazilian Cherry, Ipe, TigerWood, Cumaru, Oak, Maple, Cherry, and Rosewood. Certified FSC Green Floor.",
                "hardwood, flooring, floor, deck, decking, prefinished, unfinished, wood, solid, engineered, exotic, cheap, discount, brazilian, cherry, chestnut, walnut, canarywood, ipe, lapacho, maple, cumaru, patagonian, tiete, rosewood, tigerwood, tarara, oak, specializing, certified, green, fsc");

        }
    }
}
