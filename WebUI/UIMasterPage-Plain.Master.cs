using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace WebUI
{
    public partial class UIMasterPage_Plain : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Prevent HTTPS mode 
            if (Request.IsSecureConnection)
            {
                if ( !Request.Url.AbsoluteUri.Contains("fantastic") )
                {
                    Response.Redirect(Request.Url.AbsoluteUri.Replace("https://", "http://"), false);
                    return;
                }
            }
            this.Page.LoadComplete += new EventHandler(Page_LoadComplete);

            //set the welcome text in header
            if (Session["CustName"] == null | Session["Discount"] == null)
            {
                //this.WelcomeText.Text = "<a href=login.aspx>Please Log In</a>";
            }
            else
            {
                if (Session["Discount"].ToString() == "0")
                {
                    //this.WelcomeText.Text = Session["CustName"].ToString();
                    //this.WelcomeText.Text = this.WelcomeText.Text + "<br /><a href=login.aspx>Log Out</a>";
                }
                else
                {
                    //this.WelcomeText.Text = Session["CustName"].ToString();// +" -" + Session["Discount"].ToString() + "%";
                    //this.WelcomeText.Text = this.WelcomeText.Text + "<br /><a href=login.aspx>Log Out</a>";
                }
            }
            //this.WelcomeText.CssClass = "welcome-text";
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
            
            // Add a Keywords meta tag        
            metaTag = new HtmlMeta();        
            metaTag.Name = "Keywords";        
            metaTag.Content = keywords;        
            headTag.Controls.Add(metaTag);
        }

        public decimal CartTotal()
        {
            //return this.ShoppingCartPlugin.Cart._Cart.FindByCartId((Guid)Session["StoneWoodCartId"]).OrderSubTotal;
            return 0;
        }

        protected override void OnInit(EventArgs e) {
            base.OnInit(e);
            this.Page.LoadComplete += new EventHandler(Page_LoadComplete);
        }

        private void Page_LoadComplete(object sender, EventArgs e) {
            Page page = sender as Page;
            if (page == null) return;
        }

        private string ParseHolderContent(ContentPlaceHolder holder) {
            if (holder == null || holder.Controls.Count == 0) return string.Empty;

            LiteralControl control = holder.Controls[0] as LiteralControl;
            if (control == null || string.IsNullOrEmpty(control.Text)) return string.Empty;

            return control.Text.Trim();
        }
    } 
}
