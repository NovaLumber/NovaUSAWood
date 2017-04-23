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
    public partial class fsc_engineered_flooring : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "FSC Engineered Exotic Flooring | FSC Engineered Floors | Tropical Flooring | Nova USA",
                "FSC Hardwood Engineered Flooring and Floors - Specializing in Exotic and Domestic FSC Flooring, and Engineered Prefinished Solid Hardwood. Certified, IBAMA, Green.",
                "fsc, tropical, pre-finished, prefinished, exotic hardwood, domestic hardwood, engineered flooring, exotic floor, engineered wood, solid, exotic, cheap, discount, specializing, certified, ibama, green");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "grapes");
            } 

        }
    }
}
