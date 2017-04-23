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
    public partial class Default : System.Web.UI.Page
    {
        protected DataAccessLayer daLayer = new DataAccessLayer();

        protected void Page_Load(object sender, EventArgs e)
        {
            //This is the default for std pages
            
            UiMasterPage masterPage = (UiMasterPage)Master;

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "child");

                this.DropDownListColor.DataSource = new DataAccessLayer().GetColors();
                this.DropDownListColor.DataTextField = "color_desc";
                this.DropDownListColor.DataValueField = "filter_id";
                this.DropDownListColor.DataBind();
                this.DropDownListColor.Items.Insert(0, "Select Color");
                //this.DropDownListColor.SelectedIndex = 0;

                this.DropDownListSpecies.DataSource = new DataAccessLayer().GetSpecies(1);
                this.DropDownListSpecies.DataTextField = "species_description";
                this.DropDownListSpecies.DataValueField = "FilterEntry_ID";
                this.DropDownListSpecies.DataBind();
                this.DropDownListSpecies.Items.Insert(0, "Select Species");
                //this.DropDownListSpecies.SelectedIndex = 0;

                this.DropDownListTexture.DataSource = new DataAccessLayer().GetTextures();
                this.DropDownListTexture.DataTextField = "texture_desc";
                this.DropDownListTexture.DataValueField = "filter_id";
                this.DropDownListTexture.DataBind();
                this.DropDownListTexture.Items.Insert(0, "Select Texture");
                //this.DropDownListColor.SelectedIndex = 0;

            } 
        }

        protected void FloorFinderGo_Click(object sender, EventArgs e)
        {
            string myRedirect;
            string myFilter = "449";

            if (this.DropDownListColor.SelectedIndex > 0) 
            {
                myFilter = this.DropDownListColor.SelectedValue.ToString();
            }

            if (this.DropDownListTexture.SelectedIndex > 0)
            {
                myFilter = this.DropDownListTexture.SelectedValue.ToString();
            }

            if (this.DropDownListSpecies.SelectedIndex > 0)
            {
                myFilter = this.DropDownListSpecies.SelectedValue.ToString();
            }

            myRedirect = "Products.aspx?FilterstoAdd=" + myFilter;

            Response.Redirect(myRedirect, false);
        }

    }
}
