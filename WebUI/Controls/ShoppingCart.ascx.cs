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
    public partial class ShoppingCart : System.Web.UI.UserControl
    {
        protected string displayStyle;
        protected string ScriptText;

        protected override void OnLoad(EventArgs e)
        {
            displayStyle = "";

            base.OnLoad(e);  // TODO:  Should this be at the end of the method?

            // TODO: Revisit this. Is this needed any more? If so, where should it live, and is this the correct name?
            //Session["forceSessionStart"] = "forceSessionStart";

            if (String.Equals(Request["OpenCart"], "true", StringComparison.CurrentCultureIgnoreCase))
            {
                // TODO: Please check this out and see if this stuff needs to live here.  Is there a better way?
                
                displayStyle = "display:block;";
                //This script is to load the cart when we wish for it to be open at start
                ScriptText = "var theCookie=document.cookie;var cookieName = 'CartId';"
                    + "var ind=theCookie.indexOf(cookieName);var ind1=theCookie.indexOf(';',ind);if(ind1<0)ind1=theCookie.length;"
                    + "UpdateCart('CartView',unescape(theCookie.substring(ind+cookieName.length+1,ind1)))";
            }
        }
    } 
}