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
    public partial class massaranduba_decking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Massaranduba Decking | Massaranduba Hardwood Decks | Massaranduba Exterior Decking | Nova USA",
                "Specializing in Massaranduba Decking, Massaranduba Hardwood Decking, Exotic, Brazilian Redwood, Certified, FSC, IBAMA, Green.",
                "tropical, massaranduba, massaranduba hardwood, massaranduba deck, massaranduba decking, massaranduba wood, solid, exotic, cheap, discount, specializing, certified, green, fsc");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "cherries");
            }
        }
    }
}

