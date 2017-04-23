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
using BusinessTier.DataAccessLayer;
using BusinessTier.Utility;

namespace WebUI
{
    public partial class thank_you : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            //This is the default for std pages
            UiMasterPage masterPage = (UiMasterPage)Master;
            masterPage.SetMetaTags(
                "Thank you for registering with Nova",
                "Nova account registration confirmation. Thank you.",
                "nova usa wood products, thank you, registering, new account");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "martini");
            }
        }
    }
}
