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
using System.Collections.Generic;

namespace WebUI
{

    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // moved to Page_LoadComplete event to handle the title and metas generated after applying the filter

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "map");

                /*if (prodFilter = "459") { catalogHeader.Attributes.Add("class", "h1DeckFinder"); }*/
               
            }
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            string myFilter;
            if (Session["LastFilter"] == null)
            {
                myFilter = "Hardwood Flooring and Decking";
            }
            else
            {
                myFilter = Session["LastFilter"].ToString();
            }

            UiMasterPage masterPage = (UiMasterPage)Master;
            masterPage.SetMetaTags(
                myFilter + " Product Catalog - Hardwood Flooring and Decking, Nova USA Wood Products",
                "Shop for " + myFilter + " at Nova USA Wood Products",
                myFilter + ", shop, catalog, hardwood, decking, flooring, collection");
        }

    }
}