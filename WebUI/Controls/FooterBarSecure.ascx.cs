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

namespace WebUI.Controls
{
    // TODO:  Provide Functionality Description / Purpose
    public partial class FooterBarSecure : System.Web.UI.UserControl
    {
        // TODO:  Why are these hard wired here? No idea-SG.
        protected string HomeImage = "home_off.gif";
        protected string ProductsImage = "products_off.gif";
        protected string LearnImage = "learn_off.gif";
        protected string LocationsImage = "locations_off.gif";
        protected string AboutImage = "about_off.gif";

        #region Methods

        protected void Page_Load(object sender, EventArgs e)
        {
            // TODO:  Provide Functionality Description / Purpose

            string testString = Page.Request.Path.Substring(Page.Request.Path.LastIndexOf('/') + 1).ToLower();

            // Check to see what the Page is.
            switch (testString)
            {
                case "default.aspx":
                    HomeImage = "home.gif";
                    break;
                case "productdetails.aspx":
                case "products.aspx":
                    Session["SrchText"] = "%";  //TODO:  Is this dead code?
                    ProductsImage = "products.gif";
                    break;
                case "learn.aspx":
                    LearnImage = "learn.gif";
                    break;
                case "locations.aspx":
                    LocationsImage = "locations.gif";
                    break;
                case "about.aspx":
                    AboutImage = "about.gif";
                    break;
                default:
                    HomeImage = "home.gif";
                    break;
            }
        }

        #endregion
    } 
}