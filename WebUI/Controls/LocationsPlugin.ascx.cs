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

namespace WebUI.Controls
{

    // TODO:  Provide Functionality Description / Purpose
    public partial class LocationsPlugin : System.Web.UI.UserControl
    {
        protected DataAccessLayer daLayer = new DataAccessLayer();
        protected global::System.Web.UI.WebControls.Repeater locationSelect;

        #region

        protected void Page_Load(object sender, EventArgs e)
        {
            // TODO:  Provide Functionality Description / Purpose
            locationSelect.DataSource = daLayer.GetLocationsList().Location;
            locationSelect.DataBind();
        }

        #endregion

    } 
}