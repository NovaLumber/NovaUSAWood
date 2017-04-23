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
    public partial class warehouse_locations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Warehouse Locations | California, Colorado, New Jersey, New Hampshire, Oregon, South Carolina | Nova USA",
                "With warehouse locations across the US, Nova can ship from California, Colorado, New Jersey, New Hampshire, Oregon, and South Carolina. We stock Prefinished Flooring, Unfinished Flooring and Hardwood Decking.",
                "warehouse locations, shipping, available, Oakland, Alameda, California; Denver, Colorado; Bellmawr, New Jersey; Tilton, New Hampshire; Clackamas, Portland, Oregon; Goose Creek, Charleston, South Carolina");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "child");
            }

        }
    }
}
