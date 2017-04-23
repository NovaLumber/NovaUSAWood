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
    public partial class stonewood_hardwood_flooring : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Stonewood Hardwood Flooring | Prefinished Hardwood Flooring | Engineered Wood Floors",
                "Stonewood Hardwood Flooring offers high quality prefinished and engineered hardwood floors at discount pricing for maximum value to the consumer.",
                "Stonewood, Hardwood, Flooring, high quality, prefinished, engineered, floors, discount pricing, maximum value, consumer, Acacia, Kempas, White Oak, Handscraped, Birch, Maple");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "horses");
            }

        }
    }
}
