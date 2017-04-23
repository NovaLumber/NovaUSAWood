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
using System.Windows.Forms;

namespace WebUI
{
    public partial class color_design_tool : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            //This is the default for std pages
            UIMasterPage_Plain masterPage = (UIMasterPage_Plain)Master;
            masterPage.SetMetaTags(
                "Color Designer Tool | Paint Choice, Cabinets, Flooring, Molding",
                "Our Color Palette Designer Tool will help you select the perfect paint colors for your new flooring or cabinets.",
                "color, palette, designer, tool, select, paint, accent, flooring, cabinets, molding, factory, direct, discount, close out, wholesale, retail, portland, oregon");

            if (Request.Cookies["thedesign"] != null)
            {
                //this does work. gets cookie saved.
                HttpCookie aCookie = Request.Cookies["thedesign"];
                //Label1.Text = aCookie.Value.ToString();
            }
        }

        protected void SaveDesignToAccount_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["thedesign"] != null)
            {
                //HttpCookie aCookie = Request.Cookies["thedesign"];
                //MessageBox.Show(aCookie.Value.ToString());
            }
        }

    }
}
