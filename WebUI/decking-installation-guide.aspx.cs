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
    public partial class decking_installation_guide : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //This is the default for std pages
            UiMasterPage masterPage = (UiMasterPage)Master;
            masterPage.SetMetaTags(
                "Decking Installation Guide | Tips and Tricks",
                "Decking installation guide from Nova USA.",
                "deck, decking, installation, guide, tips, tricks");


            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "forest");
            }
        }
    }
}
