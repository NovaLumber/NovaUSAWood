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
    public partial class elemental_exotics : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Elemental Exotics Flooring Collection | Elemental Exotics Wood Floors",
                "Elemental Exotics Hardwood Flooring offers high quality prefinished solid exotic tropical hardwood floors - the highest quality, premium flooring on the market.",
                "Elemental, Exotics, Hardwood, Flooring, high quality, prefinished, floors, tropical, wood, highest, premium, brazilian, cherry, ipe, walnut, cumaru, tigerwood, tarara, kurupayra, amendoim, tiete rosewood, sirari, angico, lapacho, canary wood");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "grapes");
            }
        }
    }
}
