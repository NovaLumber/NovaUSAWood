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
    public partial class prefinished_flooring : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            /*
             masterPage.SetMetaTags(
                "Prefinished Hardwood Flooring, Exotic & Domestic Hardwoods",
                "Providing Prefinished Hardwood Flooring. Importer, Supplier & Wholesaler of Exotic and Domestic Prefinished Hardwood Flooring.",
                "tropical, prefinished, exotic hardwood, prefinished flooring, exotic floor, prefinished wood, solid, exotic, cheap, discount, specializing, certified, green, fsc");
            */

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "map");
            }

        }
    }
}

