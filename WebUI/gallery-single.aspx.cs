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
    public partial class gallery_single : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["PhotoName"] = Request.QueryString["photo"];

            FullScreen masterPage = (FullScreen)Master;

            masterPage.SetMetaTags(
                "Nova USA Wood Products - High Resolution Photo Viewer",
                "Photo Gallery for Nova USA. High resolution detailed photos and images. Decking, Prefinished, Unfinished Solid Hardwood and Engineered Flooring.",
                "photo, gallery, photos, pictures, xga, uxga, sxga, 1024x768, 1280x1024, 1600x1200, products, images, high, resolution, detailed, flooring, decking");

        }
    }
}
