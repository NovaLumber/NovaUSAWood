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
    public partial class elemental_world : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Elemental World Flooring Collection | Elemental World Wood Floors",
                "Elemental World Hardwood Flooring offers high quality prefinished solid tropical hardwood floors at discount pricing for maximum value to the consumer.",
                "Elemental, World, Hardwood, Flooring, high quality, prefinished, solid, tropical, exotic, floors, discount pricing, maximum value, consumer, acacia, kempas, taun, bankirai, yellow balau, red balau");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "map");
            }
        }
    }
}
