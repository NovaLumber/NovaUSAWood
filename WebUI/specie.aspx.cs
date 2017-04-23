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
    public partial class specie : System.Web.UI.Page
    {
        protected Species.speciesDataTable SpecieTable;
        protected Species.speciesRow SpecieRow;
        protected Species.speciesRow mySpecie;
        protected DataAccessLayer daLayer = new DataAccessLayer();

        protected void Page_Load(object sender, EventArgs e)
        {
            
            int isWood = 1;

            SpecieRepeater.DataSource = daLayer.GetSpecies(isWood).Rows;
            SpecieRepeater.DataBind();

            string speciecode;

            Species.speciesDataTable result;
            speciecode = Page.Request["code"];
            result = daLayer.GetSpecie(speciecode);
            mySpecie = result.FindByspecies_code(speciecode);

            /*
            int prodid;

            prodid = Convert.ToInt16(mySpecie.prod_id);

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
                ProductPhotoRow.filename = "/images/site/PhotoComingSoon.jpg";
            }
            */

            UiMasterPage masterPage = (UiMasterPage)Master;

            if (speciecode == "VI" || speciecode == "FA" || speciecode == "LO" || speciecode == "BR" || speciecode == "CO")
            /* imported plywood species only */
            {
                masterPage.SetMetaTags(
                    mySpecie.species_description + " Plywood - " + mySpecie.species_description + " Imported Plywood and Panels",
                    mySpecie.species_description + " Plywood from Nova USA Wood Products. Imported Plywood and Panels. " + mySpecie.species_description + " Wood, Green Certified.",
                    mySpecie.species_description + " Imported Plywood, " + mySpecie.other_names + ", Nova USA, Specializing, Discount, Wood, Solid, Engineered, Hardwood, Green, Certified");
            }
            else if (speciecode == "CA" || speciecode == "AN" || speciecode == "GH" || speciecode == "GA" || speciecode == "MD" || speciecode == "WR")
            /* decking species only */
            {
                masterPage.SetMetaTags(
                    mySpecie.species_description + " Exterior Hardwood Decking",
                    "Providing " + mySpecie.species_description + " Exterior Hardwood Decking. Imported Hardwood Exterior Decks. Direct importer, supplier and wholesaler of " + mySpecie.species_description + " Exterior Hardwood Decking." ,
                    mySpecie.species_description + " Hardwood Exterior Decking, " + mySpecie.other_names + "Wood and Decks, Nova USA, Specializing, Discount, Wood, Solid, Engineered, Hardwood, Green, Certified");
            }
            else if (speciecode == "AC" || speciecode == "AD" || speciecode == "AM" || speciecode == "AW" || speciecode == "BA" ||
                     speciecode == "BI" || speciecode == "BW" || speciecode == "CH" || speciecode == "CR" || speciecode == "GU" || speciecode == "JA" ||
                     speciecode == "KE" || speciecode == "KU" || speciecode == "LA" || speciecode == "MC" || speciecode == "MP" ||
                     speciecode == "MO" || speciecode == "QT" || speciecode == "SA" || speciecode == "SU" || speciecode == "TA" ||
                     speciecode == "TC" || speciecode == "TI" || speciecode == "TJ" || speciecode == "TN" || speciecode == "TR" ||
                     speciecode == "TX" || speciecode == "WN" || speciecode == "WO" || speciecode == "TN" || speciecode == "TR" )
            /* flooring species only */
            {
                masterPage.SetMetaTags(
                mySpecie.species_description + " Prefinished & Unfinished Hardwood Flooring",
                "Providing " + mySpecie.species_description + " Prefinished & Unfinished Hardwood Flooring. Direct importer, supplier and wholesaler of " + mySpecie.species_description + " Hardwood Floors." ,
                mySpecie.species_description + " Hardwood Flooring, " + mySpecie.species_description + " Hardwood Prefinished Flooring, Solid, Engineered");
            }
            else
            /* default if not specified */
            {
                masterPage.SetMetaTags(
                    mySpecie.species_description + " Prefinished & Unfinished Hardwood Flooring & Exterior Hardwood Decking",
                    "Providing " + mySpecie.species_description + " Prefinished & Unfinished Hardwood Flooring & Exterior Hardwood Decking. Direct importer, supplier and wholesaler of " + mySpecie.species_description,
                    mySpecie.species_description + " Hardwood Flooring & Decking, " + mySpecie.other_names + ", Nova USA, Specializing, Discount, Wood, Domestic, Exotic, Prefinished, Unfinished, Solid, Engineered, Hardwood, Green, Certified");
            }

            if (!IsPostBack)
            {
                HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                div.Attributes.Add("class", "forest");
            }

        }
    }
}
