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
    public partial class angelim_decking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Angelim Pedra Decking | Angelim Hardwood Decks | Angelim Exterior Decking | Nova USA",
                "Specializing in Angelim Pedra Decking, Angelim Hardwood Decking, Exotic, Para Angelim, Angelim Pedra Hardwood. Certified, FSC, IBAMA, Green.",
                "tropical, angelim pedra, angelim pedra hardwood, angelim pedra flooring, angelim pedra floor, angelim pedra deck, angelim pedra decking, prefinished, unfinished, angelim pedra wood, solid, engineered, exotic, cheap, discount, para angelim, oak, specializing, certified, green, fsc");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "angelim-deck");
            }

        }
    }
}
