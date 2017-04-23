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
    public partial class ipe_decking_vs_cumaru_decking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //This is the default for std pages
            UiMasterPage masterPage = (UiMasterPage)Master;
            masterPage.SetMetaTags(
                "Comparison of Ipe Decking vs. Cumaru Decking | Hardwood Deck Comparison",
                "Article summarizing the differences in terms of strength, durability and availability of Ipe Decking vs. Cumaru Decking.",
                "article, summary, differences, strength, durability, availability, Ipe, Cumaru, Brazil, Peru, Bolivia, Guyana, Columbia, South America, performance, decks, residential, decking, wood, hardwood");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "forest");
            }

        }
    }
}
