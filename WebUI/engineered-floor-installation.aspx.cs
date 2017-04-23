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
    public partial class engineered_floor_installation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Engineered Floor Installation | Installing Engineered Hardwood Flooring | Nova USA",
                "Guide to Installing Engineered Wood Floors, Installation of Engineered Hardwood Floors, Installing Prefinished, Engineered Flooring",
                "installing engineered wood floors, engineered hardwood floor installation, installing engineered flooring, how to install an engineered  floor, engineered wood floor information, help with installation, engineered hardwood floors, prefinished flooring");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "mud");
            }

        }
    }
}
