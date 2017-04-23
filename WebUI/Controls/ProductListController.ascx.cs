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
using System.Text.RegularExpressions;
using BusinessTier.DataAccessLayer;
using BusinessTier.Products;

namespace WebUI.Controls
{
    [Serializable]
    public partial class ProductListController : System.Web.UI.UserControl
    {
        protected global::System.Web.UI.WebControls.TextBox txtSearch; 
        protected global::System.Web.UI.WebControls.Button btnSearch;
        protected global::System.Web.UI.WebControls.Button btnClear;
        protected global::System.Web.UI.WebControls.Repeater ProductDisplay;

        private BusinessTier.DataAccessLayer.ProductList.productsRow prodRow;

        protected DataAccessLayer daLayer = new DataAccessLayer();
        protected SelectedFilter[] selected;
        protected Attributes.AttributeListingDataTable ProductAttributes;

        int discount;
        decimal priceFactor;

        protected override void Construct()
        {
            base.Construct();

            DataAccessLayer daLayer = new DataAccessLayer();
            ProductAttributes = daLayer.GetProductListAttributeListing();
        }

        protected override void OnPreRender(EventArgs e)
        {

            base.OnPreRender(e);

            //on page load, get discount rate if logged in, apply discount to pricing in aspx page using method GetPriceFactor
            if (Session["Discount"] == null)
            {
                discount = 0;
                priceFactor = 1;
            }
            else
            {
                discount = Int32.Parse(Session["Discount"].ToString());
                priceFactor = 1 - (decimal)discount * (decimal).01;
            }

            FilterManager fm = (FilterManager)this.Parent.FindControl("FilterManager1");
            selected = fm.SelectedFilters;

            if (Session["SrchText"] == null)
            {
                Session["SrchText"] = "%";
            }

            string TempString = Session["SrchText"].ToString();

            if (TempString.Length > 2)
            {
                ProductDisplay.DataSource = daLayer.GetProductList(selected, TempString).Rows;
                ProductDisplay.DataBind();
            }
            else
            {
                ProductDisplay.DataSource = daLayer.GetProductList(selected).Rows;
                ProductDisplay.DataBind();
            }

            foreach (SelectedFilter sf in selected)
            {
                /* numbers represent filters that are exclusively decking */
                if ( (sf.EntryId.ToString() == "451") || (sf.EntryId.ToString() == "488")
                    || (sf.EntryId.ToString() == "489") || (sf.EntryId.ToString() == "490")
                    || (sf.EntryId.ToString() == "3") || (sf.EntryId.ToString() == "8")
                    || (sf.EntryId.ToString() == "462") || (sf.EntryId.ToString() == "483")
                    || (sf.EntryId.ToString() == "491") || (sf.EntryId.ToString() == "506"))
                { 
                    catalogHeader.Attributes.Add("class", "h1DeckFinder"); 
                }
            }

        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void LoadData()
        {
            ProductDisplay.DataSource = daLayer.GetProductList(selected).Rows;
            ProductDisplay.DataBind();
        }

        protected string SetProdRow(BusinessTier.DataAccessLayer.ProductList.productsRow p)
        {
            prodRow = p;
            return "";
        }

        protected decimal GetPriceFactor()
        {
            return (decimal)priceFactor;
        }

        protected string GetAttributeValue(string AttributeName)
        {
            // not used at this time, 11/08 SG
            switch (AttributeName)
            {
                case "Species":
                    return prodRow.speciesRow.species_description;
                case "Grade":
                    return prodRow.gradeRow.grade_desc;
                case "Grain":
                    return prodRow.grainRow.grain_desc;
                case "Usage":
                    return prodRow.usageRow.usage_desc;
                case "Condition":
                    return prodRow.conditionRow.condition_desc;
                case "Inventory":
                    return prodRow.inventory_label;
                case "WeightClass":
                    if (!prodRow.Isweight_idNull())
                        return prodRow.weight_classRow.weight_desc + "(" + prodRow.weight_classRow.weight_short_desc + ")";
                    return "";
                case "WeightPerBoardFoot":
                    if (!prodRow.Isweight_idNull())
                        return prodRow.weight_classRow.weight_per_mbf + " lb";
                    return "";
                case "Size":
                    return prodRow.sizesRow.size_desc;
                case "NominalSize":
                    return prodRow.sizesRow.size_nom_thick + " x " + prodRow.sizesRow.size_nom_width;
                case "NetSize":
                    return prodRow.sizesRow.net_thick.ToString("N3") + " x " + prodRow.sizesRow.net_width.ToString("N3");
                case "BoardFeetPerBox":
                    return prodRow.bf_per_unit_of_sale.ToString();
                case "Price":
                    return (priceFactor * prodRow.web_price).ToString("C") + " " + prodRow.unitRow.price_label;
                case "PricePerBox":
                    return (priceFactor * prodRow.web_price * prodRow.bf_per_unit_of_sale).ToString("C");
                default:
                    return "Error: Attribute " + AttributeName + " is not in the database";
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Session["SrchText"] = CleanInput(this.txtSearch.Text);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {

            this.txtSearch.Text = "";
        }

        String CleanInput(string strIn) // Declare Scope
        {
            // Replace invalid characters with empty strings.
            return Regex.Replace(strIn, @"[^\w\-]", "");
        }

        protected string showListPrice(int prod_id)
        {
            ProductList.productsDataTable result;
            ProductList.productsRow MyProduct;

            if (Session["LoginID"] == null)
            {
                return "";
            }
            else
            {
                result = daLayer.GetProductDetails(prod_id);
                MyProduct = result.FindByprod_id(prod_id);

                if (priceFactor == 1)
                {
                    //return "Price: " + MyProduct.web_price.ToString("C") + "/LF";
                    return "";
                }
                else
                {
                    //return "Our List Price: " + MyProduct.web_price.ToString("C") + "/LF";
                    return "";
                }
            }
        }

        protected string showYourPrice(int prod_id)
        {
            ProductList.productsDataTable result;
            ProductList.productsRow MyProduct;

            if (Session["LoginID"] == null)
            {
                return "";
            }
            else
            {
                if (priceFactor == 1)
                {
                    return "";
                }
                else
                {
                    result = daLayer.GetProductDetails(prod_id);
                    MyProduct = result.FindByprod_id(prod_id);
                }

                return "Your Price: " + (MyProduct.web_price * this.priceFactor).ToString("C") + "/LF";
            }
        }
    }
}