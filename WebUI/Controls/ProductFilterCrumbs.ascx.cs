using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using BusinessTier.DataAccessLayer;
using BusinessTier.Products;
using WebUI;

namespace WebUI.Controls
{
    public partial class ProductFilterCrumbs : System.Web.UI.UserControl
    {
        FiltersDS filters;  // TODO:  Declare Scope
        SelectedFilter[] selected; // TODO:  Declare Scope
        Dictionary<int, ImageButton> FilterControls = new Dictionary<int, ImageButton>(); // TODO:  Declare Scope

        protected global::System.Web.UI.HtmlControls.HtmlGenericControl CrumbHeader; // TODO:  Move to Designer

        // On load, generates the image buttons, to preserve the required delete events
        protected void Page_Load(object sender, EventArgs e)
        {

            filters = ((FilterManager)this.Parent.FindControl("FilterManager1")).Filters;

            foreach (FiltersDS.FilterEntriesRow er in filters.FilterEntries)
            {
                ImageButton del = new ImageButton();
                del.ID = "Del_Entry_" + er.EntryId;
                del.ImageUrl = "/Theme/button-delete-filter.gif";
                del.CommandArgument = er.EntryId.ToString();
                del.CommandName = er.FilterId.ToString();
                del.Click += new ImageClickEventHandler(del_Click);
                del.Visible = false;
                FilterControls.Add(er.EntryId, del);
                this.Controls.Add(del);
            }
        }

        // generates the rendered values
        protected override void OnPreRender(EventArgs e)
        {
            // TODO:  Provide Functionality Description / Purpose
            base.OnPreRender(e);  // TODO:  Should this be at the bottom of the method?
            selected = ((FilterManager)this.Parent.FindControl("FilterManager1")).SelectedFilters;

            HtmlGenericControl prods = new HtmlGenericControl("div");
            /*prods.InnerText = "Current Filter";*/
            prods.InnerHtml = "<h3>Your Current Filter</h3>";
            CrumbHeader.Controls.Add(prods);

            for (int i = 0; i < selected.Length; ++i)
            {
                //Seperator
                HtmlGenericControl seperator = new HtmlGenericControl("div");
                /*seperator.InnerText = " " + System.Configuration.ConfigurationManager.AppSettings["CrumbSeperator"] + " ";*/
                seperator.InnerText = " ";
                CrumbHeader.Controls.Add(seperator);

                //Line Break
                HtmlGenericControl linebreak = new HtmlGenericControl("span");
                linebreak.InnerHtml = "";
                CrumbHeader.Controls.Add(linebreak);

                //Space
                HtmlGenericControl leading_space = new HtmlGenericControl("span");
                leading_space.InnerHtml = " ";
                CrumbHeader.Controls.Add(leading_space);

                //Delete
                ImageButton del = FilterControls[selected[i].EntryId];
                this.Controls.Remove(del);
                del.Visible = true;
                CrumbHeader.Controls.Add(del);

                //Space
                HtmlGenericControl trailing_space = new HtmlGenericControl("span");
                trailing_space.InnerHtml = " ";
                CrumbHeader.Controls.Add(trailing_space);

                //span to hold the 'name'
                HtmlGenericControl span = new HtmlGenericControl("span");
                span.InnerText = filters.FilterEntries.FindByEntryId(selected[i].EntryId).EntryName;
                span.Attributes["title"] = filters.FilterEntries.FindByEntryId(selected[i].EntryId).EntryDescr;
                CrumbHeader.Controls.Add(span);
            }
        }
        // removes an item from the selectedfilters members, when the stop-image is selected
        void del_Click(object sender, ImageClickEventArgs e)
        {
            // TODO:  Provide Functionality Description / Purpose
            ((FilterManager)this.Parent.FindControl("FilterManager1")).RemoveSelectedFilter(Int32.Parse(((ImageButton)sender).CommandArgument));
        }
    } 
}