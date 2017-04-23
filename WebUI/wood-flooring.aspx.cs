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
    public partial class wood_flooring : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Wood Flooring | Wood Floors | Hardwood Flooring | Nova USA",
                "Wood Flooring - Prefinished Exotic, Tropical Flooring, Prefinished and Unfinished Solid Hardwood. Certified, FSC, IBAMA, Green.",
                "wood flooring, floors, hardwood, tropical, pre-finished, prefinished, exotic hardwood, prefinished flooring, exotic floor, prefinished wood, solid, certified, green, fsc");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "child");
            }

        }
    }
}
