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
using BusinessTier.Shipping;
using System.Windows.Forms;

namespace WebUI
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        protected ProductPhotos.prodphotosDataTable ProductPhotos;
        protected ProductPhotos.prodphotosRow ProductPhotoRow;
        protected Attributes.AttributeListingDataTable ProductAttributes;
        protected ProductList.productsRow MyProduct;
        protected RelatedProducts.prodviewDataTable MyRelatedProducts;
        protected DataAccessLayer daLayer = new DataAccessLayer();

        protected override void Construct()
        {
            base.Construct();
            ProductAttributes = daLayer.GetProductDetailsAttributeListing();

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            // Enforce http
            if (Request.IsSecureConnection)
            {
                Response.Redirect(Request.Url.AbsoluteUri.Replace("https://", "http://"), false);
                return;
            }

            if (Request["Referrer"] != null)
            {
                //Had to comment out to get it to build - Referrer not in current context...
                //Referrer.Value = Request["Referrer"].ToString();
            }

            int prodid;
            ProductList.productsDataTable result;
            if (Int32.TryParse(Page.Request["ProdID"], out prodid) && (result = daLayer.GetProductDetails(prodid)) != null
                && result.Rows.Count > 0)
            {

                MyProduct = result.FindByprod_id(prodid);
            }
            else
            {
                Response.Redirect("Products.aspx", false);
            }

            AttributeRepeater.DataSource = ProductAttributes;
            AttributeRepeater.DataBind();

            ProdPhotoRepeater.DataSource = daLayer.GetProdPhotos(prodid).Rows;
            ProdPhotoRepeater.DataBind();

            ProductPhotos.prodphotosDataTable ProductPhotosTemp = daLayer.GetProdPhotos(prodid);
            if (ProductPhotosTemp.Rows.Count > 0)
            {
                ProductPhotoRow = (ProductPhotos.prodphotosRow)ProductPhotosTemp.Rows[0];
            }
            else
            {

                ProductPhotoRow = (ProductPhotos.prodphotosRow)ProductPhotosTemp.NewRow();
                ProductPhotoRow.filename = "images/photo_soon.jpg";
            }

            UiMasterPage masterPage = (UiMasterPage)Master;
            masterPage.SetMetaTags(MyProduct.long_desc + " " + MyProduct.both_desc + " " + MyProduct.class_desc + " - Nova USA Wood Products",
                MyProduct.long_desc + " " + MyProduct.class_desc + " from Nova USA Wood Products, Specializing in Flooring, Decking, Exotic, Prefinished and Unfinished, Solid and Engineered, Hardwood",
                MyProduct.long_desc + " " + MyProduct.usageRow.usage_desc + ", " + MyProduct.class_desc + " " + MyProduct.speciesRow.other_names + " from Nova USA Wood Products, Specializing in Flooring, Decking, Exotic, Prefinished and Unfinished Solid and Engineered Hardwood");

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "map");

                if ( MyProduct.class_web_desc.ToString().IndexOf("decking") != -1 )
                {
                    buyButton.Attributes.Add("href", "where-to-buy-nova-decking.aspx");
                }
            }

        }


        protected string GetAttributeValue(string AttributeName)
        {

            switch (AttributeName)
            {
                /* hardness,mor,moe,density,other_names,tang_shrink,rad_shrink */
                case "Species":
                    if (MyProduct.speciesRow.is_wood == 1)
                    {
                        return "<i>click for info about</i> <a href=" + MyProduct.speciesRow.url + " title=\"Click for more info about this species\" >" + MyProduct.speciesRow.species_description + "</a>";
                    }
                    else
                    {
                        return MyProduct.speciesRow.species_description;
                    }
                case "OtherNames":
                    return MyProduct.speciesRow.other_names;
                case "Photosensitive":
                    return MyProduct.speciesRow.photosensitive;
                case "Hardness":
                    return MyProduct.speciesRow.hardness.ToString("N0") + " (pounds)";
                case "MOR":
                    return MyProduct.speciesRow.mor.ToString("N0") + " (psi)";
                case "MOE":
                    return MyProduct.speciesRow.moe.ToString("N0") + " (1000 psi)";
                case "Density":
                    return MyProduct.speciesRow.density.ToString("N0") + " (KG/m3)";
                case "TangentialShrink":
                    return (MyProduct.speciesRow.tang_shrink * 100).ToString("N1") + "%";
                case "RadialShrink":
                    return (MyProduct.speciesRow.rad_shrink * 100).ToString("N1") + "%";
                case "Grade":
                    return MyProduct.gradeRow.grade_desc;
                case "Grain":
                    return MyProduct.grainRow.grain_desc;
                case "Usage":
                    return MyProduct.usageRow.usage_desc;
                case "Condition":
                    return MyProduct.conditionRow.condition_desc;
                case "Inventory":
                    return MyProduct.inventory_label;
                case "WeightClass":
                    if (!MyProduct.Isweight_idNull())
                        return MyProduct.weight_classRow.weight_desc + "(" + MyProduct.weight_classRow.weight_short_desc + ")";
                    return "";
                case "WeightPerBoardFoot":
                    if (!MyProduct.Isweight_idNull())
                        return MyProduct.weight_classRow.weight_per_mbf + " lb";
                    return "";
                case "Size":
                    return MyProduct.sizesRow.size_desc;
                case "NominalSize":
                    return MyProduct.sizesRow.size_nom_thick.ToString("N3") + " x " + MyProduct.sizesRow.size_nom_width.ToString("N3");
                case "NetSize":
                    return MyProduct.sizesRow.net_thick.ToString("N3") + " x " + MyProduct.sizesRow.net_width.ToString("N3");
                case "BoardFeetPerBox":
                    return MyProduct.bf_per_unit_of_sale.ToString() + " " + MyProduct.unitRow.unit_label.ToString() + " per " + MyProduct.unit_of_sale_desc.ToString();
                case "Price":
                    return MyProduct.web_price.ToString("C") + " " + MyProduct.unitRow.price_label;
                case "PricePerBox":
                    return (MyProduct.web_price * MyProduct.bf_per_unit_of_sale).ToString("C");
                default:
                    return "Error: Attribute " + AttributeName + " is not in the database";
            }
        }
    }
}