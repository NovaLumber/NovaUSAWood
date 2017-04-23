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
    public partial class elemental_heritage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Elemental Heritage Flooring Collection | Elemental Heritage Wood Floors",
                "Elemental Heritage Hardwood Flooring offers high quality prefinished and engineered handscraped hardwood floors at discount pricing for maximum value to the consumer.",
                "Elemental, Heritage, Hardwood, Flooring, high quality, handscraped, hand, scraped, prefinished, engineered, floors, discount pricing, maximum value, consumer, Acacia, Hickory, White Oak, Birch, Maple");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "mud");
            }
        }
    }
}
