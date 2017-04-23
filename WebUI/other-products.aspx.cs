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
    public partial class other_products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Unfinished Hardwood Flooring | Unfinished Wood Floors | Tropical Exotic Flooring | Nova USA",
                "Specializing in Unfinished Exotic Flooring, Exotic Unfinished Floors and Tropical Flooring, Prefinished and Unfinished Solid Hardwood. Certified, FSC, IBAMA, Green.",
                "tropical, unfinished, exotic hardwood, unfinished flooring, un-finished, exotic floor, unfinished wood, solid, exotic, cheap, discount, specializing, certified, green, fsc");
        }
    }
}
