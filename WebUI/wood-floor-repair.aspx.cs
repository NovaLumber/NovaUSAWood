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
    public partial class wood_floor_repair : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Wood Floor Repairs | Repairing A Wood Floor | Hardwood Floor Repairs | Nova USA",
                "Guide to Repairing Wood Floors, Repairs in Hardwood Floors, Installing Prefinished and Engineered Flooring",
                "repairing wood floors, hardwood floor repairs, installing wood floors, hardwood floor installation, installing hardwood floors, repair squeaky wood floors, wood floor repair, hardwood flooring repairs, how to repair a hardwood floor, wood floor information, help with repairing engineered hardwood floors, repairing prefinished flooring");


            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "martini");
            }
        }
    }
}
