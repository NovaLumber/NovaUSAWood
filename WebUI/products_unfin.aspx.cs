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
    public partial class products_unfin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Unfinished Sold Flooring | Unfinished Wood Floors",
                "Unfinished Hardwood Flooring is the highest quality unfinished solid hardwood floor available - the highest quality, premium flooring on the market.",
                "Unfinished, Exotics, Hardwood, Flooring, high quality, solid, floors, tropical, wood, highest, premium, brazilian, cherry, ipe, walnut, cumaru, tigerwood, tarara, kurupayra, amendoim, tiete rosewood, sirari, angico, lapacho, canary wood");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "mud");
            }
        }
    }
}
