using System;
using System.Data;
using System.Configuration;
using System.Collections.Generic;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using BusinessTier.DataAccessLayer;
using BusinessTier.Products;

namespace WebUI.Controls
{
    public partial class ProductMenu : System.Web.UI.UserControl
    {

        protected global::System.Web.UI.HtmlControls.HtmlGenericControl FilterListMain;

        Dictionary<int, LinkButton> Links = new Dictionary<int, LinkButton>();
        /// sets up all the controls, right before rendering

        protected DataAccessLayer daLayer = new DataAccessLayer();

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e); 

            FilterManager fm;
            fm = (FilterManager)this.Parent.FindControl("FilterManager1");
            FiltersDS filters = fm.Filters;
            SelectedFilter[] selected = fm.SelectedFilters;

            this.FindControl("TEMP").Controls.Clear();   // TODO:  Is "TEMP" dead code?
            this.Controls.Remove(this.FindControl("TEMP"));

            daLayer.UpdateFilterCounts(filters, selected);

            List<int> selectedIndexes = new List<int>(selected.Length);

            foreach (SelectedFilter sf in selected)
            {
                selectedIndexes.Add(sf.FilterId);
            }

            foreach (FiltersDS.FiltersRow filterRow in filters.Filters)
            {
                if (!selectedIndexes.Contains(filterRow.FilterId) && FilterHasEntries(filterRow))
                {
                    HtmlGenericControl ctrl = new HtmlGenericControl("li");
                    ctrl.ID = "Filter_" + filterRow.FilterId;
                    ctrl.InnerText = filterRow.FilterName;
                    ctrl.Attributes["title"] = filterRow.FilterDescr;
                    FilterListMain.Controls.Add(ctrl);

                    HtmlGenericControl UnorderedList = new HtmlGenericControl("ul");
                    ctrl.Controls.Add(UnorderedList);

                    foreach (FiltersDS.FilterEntriesRow entryRow in filterRow.GetFilterEntriesRows())
                    {
                        if (entryRow.CountIfAdded > 0)
                        {
                            HtmlGenericControl listItem = new HtmlGenericControl("li");
                            UnorderedList.Controls.Add(listItem);
                            LinkButton link = Links[entryRow.EntryId];
                            listItem.Controls.Add(link);
                            link.Visible = true;
                            link.Text = "" + entryRow.EntryName + " (" + entryRow.CountIfAdded + ")";
                        }
                    }
                }
            }
        }

        private bool FilterHasEntries(FiltersDS.FiltersRow fr)
        {
            foreach (FiltersDS.FilterEntriesRow entryRow in fr.GetFilterEntriesRows())
            {
                if (entryRow.CountIfAdded > 0)
                    return true;
            }

            return false;
        }

        /// event that occurs on page load, adds all the link buttons to the controls for the page, in order
        /// to preserve the link_click event
        protected void Page_Load(object sender, EventArgs e)
        {
            FilterManager fm;
            fm = (FilterManager)this.Parent.FindControl("FilterManager1");

            Control ct = new Control();
            ct.ID = "TEMP";
            this.Controls.Add(ct);

            foreach (FiltersDS.FilterEntriesRow entryRow in fm.Filters.FilterEntries)
            {
                LinkButton link = new LinkButton();
                link.ID = "Filter_" + entryRow.FiltersRow.FilterId + "_Entry_" + entryRow.EntryId;

                link.Attributes["title"] = "";  //this gets rid of the title=" " block that was appearing below the cursor
                link.CommandName = entryRow.FiltersRow.FilterId.ToString();
                link.CommandArgument = entryRow.EntryId.ToString();
                link.Click += new EventHandler(link_Click);
                Links.Add(entryRow.EntryId, link);
                link.Visible = false;
                ct.Controls.Add(link);
                // I think we can add line break here. SG
            }
        }
        
        /// When an item is clicked, adds the filter to the selected members list
        void link_Click(object sender, EventArgs e)
        {
            SelectedFilter sf = new SelectedFilter();
            sf.FilterId = Int32.Parse(((LinkButton)sender).CommandName);
            sf.EntryId = Int32.Parse(((LinkButton)sender).CommandArgument);
            ((FilterManager)this.Parent.FindControl("FilterManager1")).AddSelectedFilter(sf);
        }
    } 
}