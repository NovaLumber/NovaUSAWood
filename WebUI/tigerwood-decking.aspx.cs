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
    public partial class tigerwood_decking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "TigerWood Decking | TigerWood Hardwood Decks | TigerWood Exterior Decking | Nova USA",
                "Specializing in TigerWood Decking, TigerWood Hardwood Decking, Exotic, Tiger Wood, Prefinished and Unfinished Solid TigerWood Hardwood, Engineered TigerWood Flooring. Certified, FSC, IBAMA, Green.",
                "tropical, TigerWood, TigerWood hardwood, TigerWood flooring, TigerWood floor, TigerWood deck, TigerWood decking, prefinished, unfinished, TigerWood wood, solid, engineered, exotic, cheap, discount, tiger wood, specializing, certified, green, fsc");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "cherries");
            }
        }
    }
}

