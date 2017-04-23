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
    public partial class wood_floor_installation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Wood Floor Installation | Installing A Wood Floor | Hardwood Floor Installation | Nova USA",
                "Guide to Installing Wood Floors, Installation of Hardwood Floors, Installing Prefinished and Engineered Flooring",
                "installing wood floors, hardwood floor installation, installing hardwood flooring, how to install a hardwood floor, wood floor information, help with installation, engineered hardwood floors, prefinished flooring");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "grapes");
            }

        }
    }
}
