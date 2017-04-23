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
    public partial class elemental_advantage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Elemental Advantage Engineered Flooring | Elemental Engineered Wood Floors",
                "Elemental Advantage Engineered Hardwood Flooring offers high quality prefinished, value engineered, hardwood floors - the highest quality, premium flooring on the market.",
                "Elemental, Advantage, Engineered, Hardwood, Flooring, high quality, prefinished, floors, wood, highest, premium, brazilian, cherry, santos mahogany, walnut, white oak, smoked, natural, stained, birch, rubberwood, hevea");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "grapes");
            }
        }
    }
}
