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
    public partial class cumaru_decking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Cumaru Decking | Cumaru Hardwood Decks | Cumaru Exterior Decking | Nova USA",
                "Specializing in Cumaru Decking, Cumaru Hardwood Decking, Exotic, Brazilian chestnut, teak, Prefinished and Unfinished Solid Cumaru Hardwood, Engineered Cumaru Flooring. Certified, FSC, IBAMA, Green.",
                "tropical, Cumaru, Cumaru hardwood, Cumaru flooring, Cumaru floor, Cumaru deck, Cumaru decking, prefinished, unfinished, Cumaru wood, solid, engineered, exotic, cheap, discount, chestnut, teak, specializing, certified, green, fsc");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "deck");
            }
        }
    }
}
