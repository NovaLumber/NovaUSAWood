using System;
using System.Text;
using System.IO;
using System.Configuration;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Web.UI.HtmlControls;

namespace WebUI
{
    public partial class photo_gallery_next : System.Web.UI.Page
    {

        protected string myFileListing;
        protected string myImages;

        protected void Page_Load(object sender, EventArgs e)
        {
            NameValueCollection appConfig = ConfigurationManager.AppSettings;
            string myDirectory = appConfig["ResourceDirectory"];

            StringBuilder sb = new StringBuilder(1024);
            string directoryPath = myDirectory + "/images/GalleryFull";
            string localPath = "../images/GalleryFull";
            string thumbPath = "../images/GalleryThumb";
            DirectoryInfo di = new DirectoryInfo(directoryPath);
            FileInfo[] rgFiles = di.GetFiles("*.jpg");
            StringWriter fl = new StringWriter(sb);
            foreach (FileInfo fi in rgFiles)
            {
                fl.Write("<a href=\"" + localPath + "/" + fi.Name + "\" data-lightbox= \"" + "novagallery" + '"' + "><img alt=\"" + "hardwood " + fi.Name + "\" title=\"" + "hardwood " + fi.Name + "\" class=\"thumb\" src=\"" + thumbPath + "/" + fi.Name + "\" + /></a>");
                if (!File.Exists(fi.FullName.Replace("GalleryFull", "GalleryThumb")))
                {
                    ResizeImage(fi.FullName, fi.FullName.Replace("GalleryFull", "GalleryThumb"));
                }
            }
            myFileListing = fl.ToString();

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "cherries");
            }

        }

        private void ResizeImage(string photoPath, string newPath)
        {
            int thumbnailSize = 200;
            Bitmap photo = new Bitmap(photoPath);
            int width, height;

            width = photo.Width * thumbnailSize / photo.Height;
            height = thumbnailSize;

            Bitmap target = new Bitmap(width, height);
            using (Graphics graphics = Graphics.FromImage(target))
            {
                graphics.CompositingQuality = CompositingQuality.HighSpeed;
                graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                graphics.CompositingMode = CompositingMode.SourceCopy;
                graphics.SmoothingMode = SmoothingMode.HighQuality;
                graphics.PixelOffsetMode = PixelOffsetMode.HighQuality;
                graphics.DrawImage(photo, 0, 0, width, height);
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    target.Save(memoryStream, ImageFormat.Png);

                    if (!File.Exists(newPath))
                    {
                        using (FileStream diskCacheStream = new FileStream(newPath, FileMode.CreateNew))
                        {
                            memoryStream.WriteTo(diskCacheStream);
                        }
                    }
                }
                graphics.Dispose();
            }
            photo.Dispose();
            target.Dispose();


        }

    }
}