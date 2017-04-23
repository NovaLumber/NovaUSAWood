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
    public partial class nova_forest_brazil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //This is the default for std pages

            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Nova Brazil | Tropical Hardwood Flooring, Decking and Lumber | S4S S2S Slats Rough Lumber",
                "Nova Forest Brazil - Specializing in Tropical Hardwood: Jatoba, Ipe, Muiracatiara, Cumaru, Cabreuva, Goiabao, Sucupira, Angelim Pedra, Garapa, Massaranduba.",
                "Slats, Rough, Lumber, Flooring, Decking, S4S, S2S, Nova, Forest, Brazil, Specializing, Tropical, Hardwood, Jatoba, Ipe, Muiracatiara, Cumaru, Cabreuva, Goiabao, Sucupira, Angelim Pedra, Garapa, Massaranduba");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "forest");
            }
        }
    }
}
