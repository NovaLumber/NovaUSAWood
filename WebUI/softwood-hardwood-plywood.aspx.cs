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
    public partial class softwood_hardwood_plywood : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Imported Hardwood Plywood | Imported Softwood Plywood | Panels | FSC BCX CDX CCPTS",
                "Specializing in Imported Hardwood Plywood and Imported Softwood Plywood, FSC BCX CDX CCPTS, Pine, Brazilian, South America, Virola, Breu, Louro, Parica, Copaiba, Faveira, Panels",
                "hardwood, softwood, plywood, panels, bcx, ccpts, cdx, IWPA, grade, louro, virola, breu, pine, south america, parica, copaiba, faveira, fsc, green, ibama, teco");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "dogs");
            }
        }
    }
}
