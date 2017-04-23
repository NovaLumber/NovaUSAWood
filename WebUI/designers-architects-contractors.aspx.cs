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
    public partial class designers_architects_contractors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Find Designers, Architects, Contractors | Nova Flooring, Decking",
                "Need help finding a designer, architect or contractor with experience using Nova Flooring or Decking? See our directory listings.",
                "help, finding, designer, architect, contractor, builder, experience, flooring, decking, Nova, directory, listing");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "cherries");
            } 

        }
    }
}
