using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using BusinessTier.DataAccessLayer;

namespace WebUI.mobile
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //This is the default for std pages

            uiMasterPage masterPage = (uiMasterPage)Master;

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                //div.Attributes.Add("class", "map");

            }
        }
    }
}