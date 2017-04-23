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
using System.Collections.Generic;
using BusinessTier.DataAccessLayer;
using BusinessTier.Products;

// A class to manage interaction between different filters (MVC)

namespace WebUI.Controls
{
    [Serializable]
    public partial class FilterManager : System.Web.UI.UserControl
    {
        private FiltersDS m_Filters;
        private List<SelectedFilter> m_SelectedFilters;
        protected DataAccessLayer daLayer = new DataAccessLayer();
        string myFilterName;

        #region Methods

        // The loading of filters, grabs the selected filters list from the session variable
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SelectedFilters"] == null)
            {
                Session["SelectedFilters"] = new List<SelectedFilter>();
            }

            m_SelectedFilters = (List<SelectedFilter>)Session["SelectedFilters"];
            m_Filters = daLayer.GetFilters();

            //Code to add filters from the query string
            if (!IsPostBack && Page.Request["FiltersToAdd"] != null)
            {
                string[] FiltersToAdd = Page.Request["FiltersToAdd"].Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                
                m_SelectedFilters.Clear();

                foreach (string str in FiltersToAdd)
                {
                    int temp;
                    if (Int32.TryParse(str, out temp) && !FiltersCollectionContainsEntry(SelectedFilters, temp))
                    {
                        this.AddSelectedFilter(new SelectedFilter(m_Filters.FilterEntries.FindByEntryId(temp).FilterId, temp));
                    
                        myFilterName = m_Filters.FilterEntries.FindByEntryId(temp).EntryName.ToString();
                        Session["LastFilter"] = myFilterName;
                    }
                }
            }

        }

        private bool FiltersCollectionContainsEntry(SelectedFilter[] sf, int entryID)
        {
            foreach (SelectedFilter s in sf)
            {
                if (s.EntryId == entryID)
                {
                    return true;
                }
            }
            return false;
        }

        // Adds a filter to the selected list
        public void AddSelectedFilter(SelectedFilter sf)
        {
            m_SelectedFilters.Add(sf);
            Session["SelectedFilters"] = m_SelectedFilters;

            myFilterName = m_Filters.FilterEntries.FindByEntryId(sf.EntryId).EntryName.ToString();
            Session["LastFilter"] = myFilterName;
        }

        // removes a filter from the selected list
        public void RemoveSelectedFilter(int EntryId)
        {
            foreach (SelectedFilter s in m_SelectedFilters)
            {
                if (s.EntryId == EntryId)
                {
                    m_SelectedFilters.Remove(s);
                    break;
                }
            }

            Session["LastFilter"] = m_Filters.FilterEntries.FindByEntryId(m_SelectedFilters[m_SelectedFilters.Count - 1].EntryId).EntryName.ToString();
            Session["SelectedFilters"] = m_SelectedFilters;
        }

        

        #endregion

        #region Properties

        // Gets the list of available filters
        public FiltersDS Filters
        {
            get { return m_Filters; }
        }

        // Gets the list of selected filters
        public SelectedFilter[] SelectedFilters
        {
            get { return m_SelectedFilters.ToArray(); }
        }

        #endregion
    } 
}