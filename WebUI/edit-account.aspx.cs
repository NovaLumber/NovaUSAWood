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
using System.Text.RegularExpressions;
using BusinessTier.Utility;
using BusinessTier.Accounts;
using System.Net.Mail;
using System.Windows.Forms;

namespace WebUI
{
    public partial class edit_account : System.Web.UI.Page
    {
        protected DataAccessLayer daLayer = new DataAccessLayer();
        protected DataScrubber dataScrubber = new DataScrubber();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Test to see if the user has logged in.  If they have not, route them to back to the login page.
            if (Session["LoginId"] == null)
            {
                Response.Redirect("Login.aspx?Referrer=edit-account.aspx", false);
            }
            else
            {
                if (!IsPostBack)
                {
                    HtmlControl div = this.Master.FindControl("body") as HtmlControl;
                    div.Attributes.Add("class", "grapes");

                    BusinessTier.DataAccessLayer.Registrations.registered_usersDataTable userData = daLayer.GetCompanyDetails((int)Session["LoginId"]);

                    if (userData.Count == 0 )
                    {
                        Response.Redirect("Login.aspx?Referrer=edit-account.aspx", false);
                    }

                    FirstName.Text = userData[0].first_name.Trim();
                    LastName.Text = userData[0].last_name.Trim();
                    CompanyName.Text = userData[0].company_name.Trim();
                    Email.Text = userData[0].email_address.Trim();
                    Address1.Text = userData[0].address1.Trim();
                    Address2.Text = userData[0].address2.Trim();
                    City.Text = userData[0].city.Trim();
                    State.Text = userData[0].state.Trim();
                    ZIP.Text = userData[0].zip.Trim();
                    Country.Text = userData[0].country.Trim();
                    Phone.Text = userData[0].phone.Trim();
                    FAX.Text = userData[0].fax.Trim();
                    Website.Text = userData[0].website.Trim();
                    Reference.Text = userData[0].referral.Trim();
                    About.Text = userData[0].about.Trim();
                    Tagline.Text = userData[0].tagline.Trim();

                    if ( userData[0].receive_email.ToString() == "1")
                        { ReceiveEmails.Checked = true; }
                    else
                        { ReceiveEmails.Checked = false; }

                    //cust type
                    int typeInt;
                    typeInt = Convert.ToInt32(userData[0].cust_type_id);
                    AccountType.SelectedIndex = typeInt - 1;


                    //products
                    string Products = userData[0].products.ToString();
                    string SearchString = "Solid";
                    if (Products.IndexOf(SearchString) > -1)
                    { ProductCategory.Items[0].Selected = true; }

                    SearchString = "Engineered";
                    if (Products.IndexOf(SearchString) > -1)
                    { ProductCategory.Items[1].Selected = true; }

                    SearchString = "Prefinished";
                    if (Products.IndexOf(SearchString) > -1)
                    { ProductCategory.Items[2].Selected = true; }

                    SearchString = "Unfinished";
                    if (Products.IndexOf(SearchString) > -1)
                    { ProductCategory.Items[3].Selected = true; }

                    SearchString = "Exterior";
                    if (Products.IndexOf(SearchString) > -1)
                    { ProductCategory.Items[4].Selected = true; }
                    
                    
                    //species
                    string Species = userData[0].species.ToString();
                    SearchString = "Red Oak";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[0].Selected = true; }

                    SearchString = "White Oak";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[1].Selected = true; }

                    SearchString = "Maple";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[2].Selected = true; }

                    SearchString = "Birch";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[3].Selected = true; }

                    SearchString = "Walnut";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[4].Selected = true; }

                    SearchString = "Hickory";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[5].Selected = true; }

                    SearchString = "Cherry";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[6].Selected = true; }

                    SearchString = "Tigerwood";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[7].Selected = true; }

                    SearchString = "Amendoim";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[8].Selected = true; }

                    SearchString = "Kurupayra";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[9].Selected = true; }

                    SearchString = "Lapacho Ipe";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[10].Selected = true; }

                    SearchString = "Modado";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[11].Selected = true; }

                    SearchString = "Bloodwood";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[12].Selected = true; }

                    SearchString = "Fir";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[13].Selected = true; }

                    SearchString = "Jatoba";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[14].Selected = true; }

                    SearchString = "Guajara";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[15].Selected = true; }

                    SearchString = "Brazilian Walnut";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[16].Selected = true; }

                    SearchString = "Brazilian Teak";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[17].Selected = true; }

                    SearchString = "Brazilian Chestnut";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[18].Selected = true; }

                    SearchString = "Massaranduba";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[19].Selected = true; }

                    SearchString = "Andiroba";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[20].Selected = true; }

                    SearchString = "Cabreuva";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[21].Selected = true; }

                    SearchString = "Para";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[22].Selected = true; }

                    SearchString = "Curupau";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[23].Selected = true; }

                    SearchString = "Tarara";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[24].Selected = true; }

                    SearchString = "Tiete";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[25].Selected = true; }

                    SearchString = "Timborana";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[26].Selected = true; }

                    SearchString = "Batu";
                    if (Species.IndexOf(SearchString) > -1)
                    { SpeciesList.Items[27].Selected = true; }
                    
                    
                    //services
                    string Services = userData[0].services.ToString();
                    SearchString = "Retail";
                    if (Services.IndexOf(SearchString) > -1)
                    { ServicesList.Items[0].Selected = true; }

                    SearchString = "Internet";
                    if (Services.IndexOf(SearchString) > -1)
                    { ServicesList.Items[1].Selected = true; }

                    SearchString = "Interior";
                    if (Services.IndexOf(SearchString) > -1)
                    { ServicesList.Items[2].Selected = true; }

                    SearchString = "Architectural";
                    if (Services.IndexOf(SearchString) > -1)
                    { ServicesList.Items[3].Selected = true; }

                    SearchString = "Installation";
                    if (Services.IndexOf(SearchString) > -1)
                    { ServicesList.Items[4].Selected = true; }

                    SearchString = "General";
                    if (Services.IndexOf(SearchString) > -1)
                    { ServicesList.Items[5].Selected = true; }
                
                }
            }
        }

        protected void UpdateAccount_Click(object sender, EventArgs e)
        {
            // Get a RegEx to test the email against.
            DataScrubber theDataScrubber = new DataScrubber();
            Regex emailTestRegEx = theDataScrubber.GenerateEmailRegEx();

            string productsList = "";
            string speciesList = "";
            string servicesList = "";
            int UpdateAccountResult = 0;

            foreach (ListItem lstItem in ProductCategory.Items)
            {
                if (lstItem.Selected == true)
                {
                    if (productsList.Length > 2)
                    {
                        productsList += ", " + lstItem.Text;
                    }
                    else
                    {
                        productsList = lstItem.Text;
                    }
                }
            }

            foreach (ListItem lstItem in SpeciesList.Items)
            {
                if (lstItem.Selected == true)
                {
                    if (speciesList.Length > 2)
                    {
                        speciesList += ", " + lstItem.Text;
                    }
                    else
                    {
                        speciesList = lstItem.Text;
                    }
                }
            }

            foreach (ListItem lstItem in ServicesList.Items)
            {
                if (lstItem.Selected == true)
                {
                    if (servicesList.Length > 2)
                    {
                        servicesList += ", " + lstItem.Text;
                    }
                    else
                    {
                        servicesList = lstItem.Text;
                    }
                }
            }

            UpdateAccountResult = daLayer.UpdateRegisteredUser(Reference.Text.Trim(),
                    Email.Text.Trim(), CompanyName.Text.Trim(), Address1.Text.Trim(), Address2.Text.Trim(),
                    City.Text.Trim(), State.Text.Trim(), ZIP.Text.Trim(),
                    Country.Text.Trim(), dataScrubber.CleanPhoneNumber(Phone.Text.Trim()), dataScrubber.CleanPhoneNumber(FAX.Text.Trim()),
                    ReceiveEmails.Checked, AccountType.SelectedValue,
                    FirstName.Text.Trim(), LastName.Text.Trim(),
                    productsList, speciesList, servicesList, Tagline.Text.Trim(),
                    About.Text.Trim(), Website.Text.Trim(), (int)Session["LoginId"]);

            if ( UpdateAccountResult > 0 )
            {
                //success
                Response.Redirect("/thank-you.aspx", false);
            }
            else
            {
                //error
            }

        }
    }
}
