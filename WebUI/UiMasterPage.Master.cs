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
using BusinessTier.DataAccessLayer;
using System.Threading;
using System.Text;
using System.Drawing;
using System.Text.RegularExpressions;


namespace WebUI
{
    public partial class UiMasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["constantSession"] = "";

            this.Page.LoadComplete += new EventHandler(Page_LoadComplete);

            string urlRequested;

            urlRequested = Page.Request.Url.AbsoluteUri.ToString();

            if (Session["LoginId"] != null & Session["email"] != null)
            {
                logintext.Text = Session["email"].ToString();
            }
            else
            {
                logintext.Text = "";
            }

            if (urlRequested.StartsWith("http://nova"))
            {
                Response.Redirect(urlRequested.Replace("nova", "www.nova"), false);
            }

            if (urlRequested.StartsWith("https://nova"))
            {
                Response.Redirect(urlRequested.Replace("https://nova", "https://www.nova"), false);
            }

            string userAgent = Request.ServerVariables["HTTP_USER_AGENT"];
            Regex OS = new Regex(@"(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino", RegexOptions.IgnoreCase | RegexOptions.Multiline);
            Regex device = new Regex(@"1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-", RegexOptions.IgnoreCase | RegexOptions.Multiline);
            string device_info = string.Empty;
            if (OS.IsMatch(userAgent))
            {
                device_info = OS.Match(userAgent).Groups[0].Value;
            }
            if (device.IsMatch(userAgent.Substring(0, 4)))
            {
                device_info += device.Match(userAgent).Groups[0].Value;
            }
            string useMobile = System.Configuration.ConfigurationManager.AppSettings["useMobile"];
            string testMobile = System.Configuration.ConfigurationManager.AppSettings["testMobile"];
            HtmlLink link = new HtmlLink();
            HtmlHead headTag = (HtmlHead)Page.Header;
            HtmlMeta metaTag = new HtmlMeta();
            if (useMobile == "yes")
            {
                if (testMobile == "yes" || !string.IsNullOrEmpty(device_info))
                {
                    link.Attributes["href"] = "/Theme/mobile.css";
                    // Add a viewport meta tag        
                    metaTag.Name = "viewport";
                    metaTag.Content = "width=480";
                    headTag.Controls.Add(metaTag);
                }
                else
                {
                    link.Attributes["href"] = "/Theme/general.css";
                    // Add a viewport meta tag        
                    metaTag.Name = "viewport";
                    metaTag.Content = "width=980";
                    headTag.Controls.Add(metaTag);
                }
            }
            else
            {
                link.Attributes["href"] = "/Theme/general.css";
                // Add a viewport meta tag        
                metaTag.Name = "viewport";
                metaTag.Content = "width=980";
                headTag.Controls.Add(metaTag);
            }
            link.Attributes["type"] = "text/css";
            link.Attributes["rel"] = "stylesheet";
            Page.Header.Controls.Add(link);


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

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Page.LoadComplete += new EventHandler(Page_LoadComplete);
        }

        private void Page_LoadComplete(object sender, EventArgs e)
        {
            Page page = sender as Page;
            if (page == null) return;
        }

        private string ParseHolderContent(ContentPlaceHolder holder)
        {
            if (holder == null || holder.Controls.Count == 0) return string.Empty;

            LiteralControl control = holder.Controls[0] as LiteralControl;
            if (control == null || string.IsNullOrEmpty(control.Text)) return string.Empty;

            return control.Text.Trim();
        }

    }
}
