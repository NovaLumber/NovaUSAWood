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
using BusinessTier.Utility;

namespace WebUI
{
    public partial class region_decking : System.Web.UI.Page
    {
        protected RegionWeb.region_webDataTable regionTable;
        protected RegionWeb.region_webRow myRegion;
        protected DataAccessLayer daLayer = new DataAccessLayer();

        protected void Page_Load(object sender, EventArgs e)
        {
            RegionRepeater.DataSource = daLayer.GetRegionWeb().Rows;
            RegionRepeater.DataBind();

            string regionCode;
            RegionWeb.region_webDataTable result;

            try
            {
                regionCode = Page.Request["code"];
                result = daLayer.GetOneRegionWeb(Convert.ToInt16(regionCode));
                myRegion = result.FindByregion_id(Convert.ToInt16(regionCode));
            }
            catch
            {
                result = daLayer.GetOneRegionWeb(45);
                myRegion = result.FindByregion_id(45);
            }

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "batu-house");
            }
        }
    }
}