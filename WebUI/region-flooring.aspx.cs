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
    public partial class region_flooring : System.Web.UI.Page
    {
        protected RegionWebFlooring.region_web_flooringDataTable regionTable;
        protected RegionWebFlooring.region_web_flooringRow myRegion;
        protected DataAccessLayer daLayer = new DataAccessLayer();

        protected void Page_Load(object sender, EventArgs e)
        {
            RegionRepeater.DataSource = daLayer.GetRegionWebFlooring().Rows;
            RegionRepeater.DataBind();

            string regionCode;
            RegionWebFlooring.region_web_flooringDataTable result;

            try
            {
                regionCode = Page.Request["code"];
                result = daLayer.GetOneRegionWebFlooring(Convert.ToInt16(regionCode));
                myRegion = result.FindByregion_id(Convert.ToInt16(regionCode));
            }
            catch
            {
                result = daLayer.GetOneRegionWebFlooring(45);
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