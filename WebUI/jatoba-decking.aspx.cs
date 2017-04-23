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
    public partial class jatoba_decking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Jatoba Decking | Jatoba Hardwood Decks | Jatoba Exterior Decking | Nova USA",
                "Specializing in Jatoba Decking, Jatoba Hardwood Decking, Exotic, Brazilian Cherry, Prefinished and Unfinished Solid Jatoba Hardwood, Engineered Jatoba Flooring. Certified, FSC, IBAMA, Green.",
                "tropical, Jatoba, Jatoba hardwood, Jatoba flooring, Jatoba floor, Jatoba deck, Jatoba decking, prefinished, unfinished, Jatoba wood, solid, engineered, exotic, cheap, discount, Cherry, lapacho, specializing, certified, green, fsc");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "forest");
            }
        }
    }
}
