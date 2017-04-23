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

namespace WebUI
{

    public partial class woodstrength : System.Web.UI.Page
    {

        protected Species.speciesDataTable SpecieTable;
        protected Species.speciesRow SpecieRow;
        protected DataAccessLayer daLayer = new DataAccessLayer();

        protected void Page_Load(object sender, EventArgs e)
        {
            int isWood = 1;

            SpecieRepeater.DataSource = daLayer.GetSpeciesMOR(isWood).Rows;
            SpecieRepeater.DataBind();

            UiMasterPage masterPage = (UiMasterPage)Master;

            masterPage.SetMetaTags(
                "Nova USA Wood Products - Wood Strength, MOR",
                "Specializing in Prefinished, Unfinished Solid Hardwood, Engineered Flooring and Decking - Exotic, Brazilian Cherry, Ipe, TigerWood, Cumaru, Oak, Maple, Cherry, and Rosewood. Certified FSC Green Floor.",
                "hardwood, flooring, floor, deck, decking, prefinished, unfinished, wood, solid, engineered, exotic, cheap, discount, brazilian, cherry, chestnut, walnut, canarywood, ipe, lapacho, maple, cumaru, patagonian, tiete, rosewood, tigerwood, tarara, oak, specializing, certified, green, fsc");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "martini");
            }
        }
    }
}