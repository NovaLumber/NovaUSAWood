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
    public partial class FullScreen : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void SetMetaTags(string title, string description, string keywords)
        {
            // Get a reference to the HTML Head        
            HtmlHead headTag = (HtmlHead)Page.Header;

            // Set the page title        
            headTag.Title = title;

            // Add a Description meta tag        
            HtmlMeta metaTag = new HtmlMeta();
            metaTag.Name = "Description";
            metaTag.Content = description;
            headTag.Controls.Add(metaTag);

            // Add a return, if we can figure out how
            //Html32TextWriter myHtml = new Html32TextWriter;
            //myHtml.NewLine;
            //headTag.Controls.Add(myHtml);

            // Add a Keywords meta tag        
            metaTag = new HtmlMeta();
            metaTag.Name = "Keywords";
            metaTag.Content = keywords;
            headTag.Controls.Add(metaTag);
        }
    }
}
