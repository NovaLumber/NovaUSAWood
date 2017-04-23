using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.IO;
using System.Data;
using System.Xml;
using System.Net;
using System.Configuration;
using System.Diagnostics;
using System.Security.Cryptography;
using BusinessTier.Utility;
using BusinessTier.Shipping;
using BusinessTier.Shopping;
using BusinessTier.Products;
using BusinessTier.Promotions;

namespace BusinessTier.DataAccessLayer
{
    public class DataAccessLayer
    {
        private SqlConnection DbConnection;
        private ErrorHandler ErrHandler = new ErrorHandler();
        private Dictionary<string, ShippingOption[]> options = new Dictionary<string, ShippingOption[]>();

        //Constructor
        public DataAccessLayer()
        {
            this.OpenConnection();
        }

        private void OpenConnection()
        {
            // Verify that connnection is not null
            if (DbConnection == null)
            {
                DbConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["NovaDatabase"].ConnectionString);
            }

            // Handle various Connections States
            switch (DbConnection.State)
            {
                case ConnectionState.Open:
                    // This is the proper path.
                    return;

                case ConnectionState.Broken:
                    DbConnection.Close();
                    DbConnection.Open();
                    break;

                case ConnectionState.Closed:
                    DbConnection.Open();
                    break;

                //case ConnectionState.Connecting:
                //    throw new System.NotImplementedException();

                //case ConnectionState.Executing:
                //    throw new System.NotImplementedException();

                //case ConnectionState.Fetching:
                //    throw new System.NotImplementedException();

                default:
                    Exception UnhandledConnectionState = new Exception();
                    throw UnhandledConnectionState;
            }
        }

        public void CloseConnection()
        {
            if (DbConnection.State != ConnectionState.Closed)
            {
                DbConnection.Close();
            }
        }

        public Locations GetLocationsList()
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SP_GetWebLocations";
            Locations loc = new Locations();
            loc.EnforceConstraints = false;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.TableMappings.Add("Table", "Category");
            da.TableMappings.Add("Table1", "Location");
            da.TableMappings.Add("Table2", "Hours");
            da.Fill(loc);
            loc.EnforceConstraints = true;
            cmd.Dispose();
            return loc;
        }

        public ProductList.productsDataTable GetProductList()
        {
            return GetProductList(new SelectedFilter[0]);
        }

        public ProductList.productsDataTable GetProductList(SelectedFilter[] selectedFilters)
        {
            return GetProductList(selectedFilters, "");
        }

        public ProductList.productsDataTable GetProductList(SelectedFilter[] selectedFilters, string SrchText)
        {
            string CurrentFilters = "";

            foreach (SelectedFilter sf in selectedFilters)
            {
                if (!String.IsNullOrEmpty(CurrentFilters))
                {
                    CurrentFilters += ',';
                }
                CurrentFilters += sf.EntryId;
            }

            ProductList pl = new ProductList();
            pl.EnforceConstraints = false;
            this.OpenConnection();

            SqlCommand cmd = new SqlCommand("SP_GetWebProductsList", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param = new SqlParameter("@EntryList", SqlDbType.VarChar);
            param.Value = CurrentFilters;
            cmd.Parameters.Add(param);

            SqlParameter param2 = new SqlParameter("@SrchText", SqlDbType.VarChar);
            param2.Value = SrchText;
            cmd.Parameters.Add(param2);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.TableMappings.Add("Table", "unit");
            da.TableMappings.Add("Table1", "weight_class");
            da.TableMappings.Add("Table2", "sizes");
            da.TableMappings.Add("Table3", "condition");
            da.TableMappings.Add("Table4", "usage");
            da.TableMappings.Add("Table5", "grade");
            da.TableMappings.Add("Table6", "grain");
            da.TableMappings.Add("Table7", "species");
            da.TableMappings.Add("Table8", "products");

            da.Fill(pl);
            cmd.Dispose();
            pl.EnforceConstraints = false;

            return pl.products;

        }

        public Registrations.registered_usersDataTable GetRegistrationRecords(int type, string city, string state, string zip, string productLine, string species)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetRegistrationRecords", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            Registrations.registered_usersDataTable myTable = new Registrations.registered_usersDataTable();

            SqlParameter param1 = new SqlParameter("@Type", SqlDbType.Int);
            param1.Value = type;
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@City", SqlDbType.VarChar);
            param2.Value = city;
            cmd.Parameters.Add(param2);

            SqlParameter param3 = new SqlParameter("@State", SqlDbType.VarChar);
            param3.Value = state;
            cmd.Parameters.Add(param3);

            SqlParameter param4 = new SqlParameter("@Zip", SqlDbType.VarChar);
            param4.Value = zip;
            cmd.Parameters.Add(param4);

            SqlParameter param5 = new SqlParameter("@ProductLine", SqlDbType.VarChar);
            param5.Value = productLine;
            cmd.Parameters.Add(param5);

            SqlParameter param6 = new SqlParameter("@Species", SqlDbType.VarChar);
            param6.Value = species;
            cmd.Parameters.Add(param6);

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            //myTable.EnforceConstraints = false;
            da.Fill(myTable);

            cmd.Dispose();

            return myTable;
        }

        public customer.customerDataTable GetCustomer(int cust_id)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetCustomer", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            customer.customerDataTable ct = new customer.customerDataTable();

            SqlParameter param = new SqlParameter("@cust_id", SqlDbType.Int);
            param.Value = cust_id;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(ct);
            cmd.Dispose();

            return ct;
        }

        public customer.cust_addressDataTable GetCustAddr(int cust_addr_id)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetCustAddr", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            customer.cust_addressDataTable ct = new customer.cust_addressDataTable();

            SqlParameter param = new SqlParameter("@cust_addr_id", SqlDbType.Int);
            param.Value = cust_addr_id;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(ct);
            cmd.Dispose();

            return ct;
        }

        public Species.speciesDataTable GetSpecie(string speciecode)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_WebGetSpecie", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            Species.speciesDataTable st = new Species.speciesDataTable();

            SqlParameter param = new SqlParameter("@SpecieCode", SqlDbType.VarChar);
            param.Value = speciecode;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(st);
            cmd.Dispose();

            return st;
        }

        public Species.speciesDataTable GetSpecies(int isWood)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_WebGetSpecies", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            Species.speciesDataTable st = new Species.speciesDataTable();

            SqlParameter param = new SqlParameter("@isWood", SqlDbType.Int);
            param.Value = isWood;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(st);
            cmd.Dispose();

            return st;
        }

        public brands.SP_WebGetBrandDataTable GetBrand(int brandID)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_WebGetBrand", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            brands.SP_WebGetBrandDataTable bt = new brands.SP_WebGetBrandDataTable();

            SqlParameter param = new SqlParameter("@brandID", SqlDbType.Int);
            param.Value = brandID;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(bt);
            cmd.Dispose();

            return bt;
        }

        public brands.SP_WebGetBrandDataTable GetBrands(int show)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_WebGetBrands", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            brands.SP_WebGetBrandDataTable bt = new brands.SP_WebGetBrandDataTable();

            SqlParameter param = new SqlParameter("@show", SqlDbType.Int);
            param.Value = show;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(bt);
            cmd.Dispose();

            return bt;
        }

        public int CheckBrand(int testBrandID)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_WebCheckBrandID", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@testID", SqlDbType.Int);
            param1.Value = testBrandID;
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@returnID", SqlDbType.Int);
            param2.Direction = ParameterDirection.Output;
            param2.IsNullable = false;
            cmd.Parameters.Add(param2);

            cmd.ExecuteScalar();
            cmd.Dispose();

            return (Int32)param2.Value;
        }

        public Species.speciesDataTable GetSpeciesHardness(int isWood)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_WebGetSpeciesHardness", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            Species.speciesDataTable st = new Species.speciesDataTable();

            SqlParameter param = new SqlParameter("@isWood", SqlDbType.Int);
            param.Value = isWood;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(st);
            cmd.Dispose();

            return st;
        }

        public Species.speciesDataTable GetSpeciesMOR(int isWood)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_WebGetSpeciesMOR", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            Species.speciesDataTable st = new Species.speciesDataTable();

            SqlParameter param = new SqlParameter("@isWood", SqlDbType.Int);
            param.Value = isWood;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(st);
            cmd.Dispose();

            return st;
        }

        public Species.speciesDataTable GetSpeciesMOE(int isWood)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_WebGetSpeciesMOE", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            Species.speciesDataTable st = new Species.speciesDataTable();

            SqlParameter param = new SqlParameter("@isWood", SqlDbType.Int);
            param.Value = isWood;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(st);
            cmd.Dispose();

            return st;
        }

        public Species.speciesDataTable GetSpeciesDensity(int isWood)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_WebGetSpeciesDensity", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            Species.speciesDataTable st = new Species.speciesDataTable();

            SqlParameter param = new SqlParameter("@isWood", SqlDbType.Int);
            param.Value = isWood;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(st);
            cmd.Dispose();

            return st;
        }

        public CheckoutTables.OrderRow GetSubmittedOrder(int OrderId)
        {
            this.OpenConnection();

            SqlCommand cmd = new SqlCommand("SP_GetSubmittedOrder", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param = new SqlParameter("@OrderId", SqlDbType.Int);
            param.Value = OrderId;
            cmd.Parameters.Add(param);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.TableMappings.Add("Table", "Order");
            da.TableMappings.Add("Table1", "Address");
            da.TableMappings.Add("Table2", "SubmittedOrderData");

            CheckoutTables ct = new CheckoutTables();
            ct.EnforceConstraints = false;
            da.Fill(ct);
            cmd.Dispose();

            ct.EnforceConstraints = true;

            return ct.Order.FindByOrderId(OrderId);
        }

        public Promotions.PromotionDataTable GetPromotions()
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetPromotions", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            Promotions.PromotionDataTable pdt = new Promotions.PromotionDataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(pdt);

            da.Dispose();
            cmd.Dispose();

            return pdt;
        }

        public PromoBlocks.PromoBlockDataTable GetPromoBlocks()
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetPromoBlocks", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            PromoBlocks.PromoBlockDataTable pdt = new PromoBlocks.PromoBlockDataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(pdt);

            da.Dispose();
            cmd.Dispose();

            return pdt;
        }

        public Specials.SP_GetSpecialsDataTable GetSpecials()
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetSpecials", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            Specials.SP_GetSpecialsDataTable dt = new Specials.SP_GetSpecialsDataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            da.Dispose();
            cmd.Dispose();

            return dt;
        }

        public ProductPhotos.prodphotosDataTable GetProdPhotos(int ProductId)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetWebProductPhotos", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            ProductPhotos.prodphotosDataTable pph = new ProductPhotos.prodphotosDataTable();

            SqlParameter param = new SqlParameter("@ProductId", SqlDbType.Int);
            param.Value = ProductId;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(pph);
            cmd.Dispose();

            return pph;
        }

        public ProductPhotos.prodphotosDataTable GetBrandPhotos(int brandID)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetWebBrandPhotos", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            ProductPhotos.prodphotosDataTable pph = new ProductPhotos.prodphotosDataTable();

            SqlParameter param = new SqlParameter("@brandID", SqlDbType.Int);
            param.Value = brandID;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(pph);
            cmd.Dispose();

            return pph;
        }

        public RelatedProducts.prodviewDataTable GetRelatedProducts(int prodid)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetRelatedProducts", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            RelatedProducts.prodviewDataTable rp = new RelatedProducts.prodviewDataTable();

            SqlParameter param = new SqlParameter("@prod_id", SqlDbType.Int);
            param.Value = prodid;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            

            da.Fill(rp);
            cmd.Dispose();

            return rp;
        }

        public Registrations.registered_usersDataTable GetCompanyDetails(int dealerID)
        {
            OpenConnection();

            Registrations dl = new Registrations();

            SqlCommand cmd = new SqlCommand("SP_GetDealer", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@user_id", SqlDbType.Int);
            param1.Value = dealerID;
            cmd.Parameters.Add(param1);

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.TableMappings.Add("Table", "registered_users");

            da.Fill(dl);
            cmd.Dispose();
            dl.EnforceConstraints = true;

            return dl.registered_users;
        }

        public ProductList.productsDataTable GetProductDetails(int ProductId)
        {
            this.OpenConnection();

            ProductList pl = new ProductList();

            SqlCommand cmd = new SqlCommand("SP_GetWebProductsDetails", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter param = new SqlParameter("@ProductId", SqlDbType.Int);
            param.Value = ProductId;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.TableMappings.Add("Table", "unit");
            da.TableMappings.Add("Table1", "weight_class");
            da.TableMappings.Add("Table2", "sizes");
            da.TableMappings.Add("Table3", "condition");
            da.TableMappings.Add("Table4", "usage");
            da.TableMappings.Add("Table5", "grade");
            da.TableMappings.Add("Table6", "grain");
            da.TableMappings.Add("Table7", "species");
            da.TableMappings.Add("Table8", "products");
            da.Fill(pl);
            cmd.Dispose();
            pl.EnforceConstraints = true;
            return pl.products;
        }

        public Attributes.AttributeListingDataTable GetProductListAttributeListing()
        {
            return GetAttributeListing("ProductList");
        }

        public Attributes.AttributeListingDataTable GetProductDetailsAttributeListing()
        {
            return GetAttributeListing("ProductDetails");
        }

        public Attributes.AttributeListingDataTable GetAttributeListing(string PageType)
        {
            this.OpenConnection();
            Attributes.AttributeListingDataTable dt = new Attributes.AttributeListingDataTable();

            SqlCommand cmd = new SqlCommand("SP_GetWebAttributes", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter param = new SqlParameter("@LocationName", SqlDbType.VarChar);
            param.Value = PageType;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            cmd.Dispose();
            return dt;
        }

        public void UpdateFilterCounts(FiltersDS current, SelectedFilter[] selectedFilters)
        {
            string CurrentFilters = "";

            foreach (SelectedFilter sf in selectedFilters)
            {
                if (!String.IsNullOrEmpty(CurrentFilters))
                {
                    CurrentFilters += ',';
                }

                CurrentFilters += sf.EntryId;
            }

            FiltersDS ds = new FiltersDS();
            ds.EnforceConstraints = false;
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SP_GetWebFilters_Count";
            SqlParameter param = new SqlParameter("@EntryList", SqlDbType.VarChar);
            param.Value = CurrentFilters;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.TableMappings.Add("Table", "FilterEntries");
            da.Fill(ds.FilterEntries);
            cmd.Dispose();

            foreach (FiltersDS.FilterEntriesRow row in current.FilterEntries)
            {
                row.CountIfAdded = ds.FilterEntries.FindByEntryId(row.EntryId).CountIfAdded;
            }
        }

        public FiltersDS GetFilters()
        {
            OpenConnection();
            FiltersDS ds = new FiltersDS();
            ds.EnforceConstraints = false;
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SP_GetWebFilters";
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.TableMappings.Add("Table", "Filters");
            da.TableMappings.Add("Table1", "FilterEntries");
            da.Fill(ds);
            ds.EnforceConstraints = true;
            cmd.Dispose();

            return ds;
        }

        public void CreateLumberIQOrder(int OrderId)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_CreateOrder", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@OrderId", SqlDbType.Int);
            param1.Value = OrderId;
            cmd.Parameters.Add(param1);

            cmd.ExecuteNonQuery();
        }

        public void SubmitOrder(int OrderId, decimal SubTotal, decimal taxCost, int ShippingOptionId, string ShippingOptionName, decimal ShippingCost, decimal Total)
        {

            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_SetOrderSubmitted", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@OrderId", SqlDbType.Int);
            param1.Value = OrderId;
            cmd.Parameters.Add(param1);

            param1 = new SqlParameter("@Subtotal", SqlDbType.Money);
            param1.Value = SubTotal;
            cmd.Parameters.Add(param1);

            param1 = new SqlParameter("@TaxCost", SqlDbType.Money);
            param1.Value = taxCost;
            cmd.Parameters.Add(param1);

            param1 = new SqlParameter("@ShippingOptionId", SqlDbType.Int);
            param1.Value = ShippingOptionId;
            cmd.Parameters.Add(param1);

            param1 = new SqlParameter("@ShippingOptionName", SqlDbType.VarChar);
            param1.Value = ShippingOptionName;
            cmd.Parameters.Add(param1);

            param1 = new SqlParameter("@ShippingCost", SqlDbType.Money);
            param1.Value = ShippingCost;
            cmd.Parameters.Add(param1);

            param1 = new SqlParameter("@Total", SqlDbType.Money);
            param1.Value = Total;
            cmd.Parameters.Add(param1);

            cmd.ExecuteNonQuery();
        }

        public WebDocuments.web_LearnDocumentDataTable GetLearnDocuments()
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetWebDocuments", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            WebDocuments.web_LearnDocumentDataTable docs = new WebDocuments.web_LearnDocumentDataTable();

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(docs);
            cmd.Dispose();

            return docs;
        }

        public Cart GetClosedCart(Guid CartId, int cust_id)
        {
            OpenConnection();
            Cart cart = new Cart();
            cart.EnforceConstraints = false;

            SqlCommand cmd = new SqlCommand("SP_GetCart", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;
            if (CartId != null && CartId != Guid.Empty)//only add if it isn't null
            {
                SqlParameter param = new SqlParameter("@CartId", SqlDbType.UniqueIdentifier);
                param.Value = CartId;
                cmd.Parameters.Add(param);
            }
            SqlParameter param2 = new SqlParameter("@GetClosed", SqlDbType.Bit);
            param2.Value = true;
            cmd.Parameters.Add(param2);

            SqlParameter param3 = new SqlParameter("@cust_id", SqlDbType.Int);
            param3.Value = cust_id;
            cmd.Parameters.Add(param3);


            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.TableMappings.Add("Table", "Cart");
            da.TableMappings.Add("Table1", "CartLine");

            da.Fill(cart);
            cmd.Dispose();

            cart.EnforceConstraints = false;
            return cart;
        }

        public Cart GetCart(Guid CartId, int cust_id)
        {
            OpenConnection();
            Cart cart = new Cart();
            cart.EnforceConstraints = false;

            SqlCommand cmd = new SqlCommand("SP_GetCart", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;
            if (CartId != null && CartId != Guid.Empty)//only add if it isn't null
            {
                SqlParameter param = new SqlParameter("@CartId", SqlDbType.UniqueIdentifier);
                param.Value = CartId;
                cmd.Parameters.Add(param);
            }

            SqlParameter param3 = new SqlParameter("@cust_id", SqlDbType.Int);
            param3.Value = cust_id;
            cmd.Parameters.Add(param3);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.TableMappings.Add("Table", "Cart");
            da.TableMappings.Add("Table1", "CartLine");

            da.Fill(cart);
            cmd.Dispose();

            cart.EnforceConstraints = false;
            return cart;
        }

        public void AddItemToCart(Guid CartId, int ProductId, int Quantity, string Comment)
        {

            if (CartId != Guid.Empty && Quantity > 0 && ProductId >= 0)
            {
                OpenConnection();
                SqlCommand cmd = new SqlCommand("SP_AddItemToCart", DbConnection);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter param1 = new SqlParameter("@CartId", SqlDbType.UniqueIdentifier);
                param1.Value = CartId;
                cmd.Parameters.Add(param1);

                SqlParameter param2 = new SqlParameter("@ProductId", SqlDbType.Int);
                param2.Value = ProductId;
                cmd.Parameters.Add(param2);

                SqlParameter param3 = new SqlParameter("@QuantityToAdd", SqlDbType.Int);
                param3.Value = Quantity;
                cmd.Parameters.Add(param3);

                SqlParameter param4 = new SqlParameter("@Comment", SqlDbType.VarChar);
                param4.Value = Comment;
                cmd.Parameters.Add(param4);

                cmd.ExecuteScalar();
                cmd.Dispose();
            }
        }

        public void SetCartStatus(Guid CartId, BusinessTier.Utility.Enums.CartStatus cs)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_SetCartStatus", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@CartId", SqlDbType.UniqueIdentifier);
            param1.Value = CartId;
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@Status", SqlDbType.Char);
            param2.Value = (char)cs;
            cmd.Parameters.Add(param2);

            cmd.ExecuteScalar();
            cmd.Dispose();
        }

        public void UpdateItemQuantities(Guid CartId, int[] ProductIds, int[] Quantities)
        {
            if (CartId != Guid.Empty && ProductIds.Length > 0 && ProductIds.Length == Quantities.Length)
            {
                string ProductIdString = "";
                string QuantityString = "";
                for (int i = 0; i < ProductIds.Length; ++i)
                {
                    if (ProductIdString.Length != 0)
                        ProductIdString += ',';
                    ProductIdString += ProductIds[i];
                    if (QuantityString.Length != 0)
                        QuantityString += ',';
                    QuantityString += Quantities[i];
                }
                OpenConnection();
                SqlCommand cmd = new SqlCommand("SP_UpdateCartItems", DbConnection);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter param1 = new SqlParameter("@CartId", SqlDbType.UniqueIdentifier);
                param1.Value = CartId;
                cmd.Parameters.Add(param1);

                SqlParameter param2 = new SqlParameter("@ProductIds", SqlDbType.VarChar);
                param2.Value = ProductIdString;
                cmd.Parameters.Add(param2);

                SqlParameter param3 = new SqlParameter("@Quantitys", SqlDbType.VarChar);
                param3.Value = QuantityString;
                cmd.Parameters.Add(param3);

                cmd.ExecuteScalar();
                cmd.Dispose();
            }
        }

        public int? Login(string EmailAddress, string password)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetLogin", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@EmailAddress", SqlDbType.VarChar);
            param1.Value = EmailAddress;
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@PasswordHash", SqlDbType.Char, 32);
            param2.Value = EncodePassword(password);
            cmd.Parameters.Add(param2);

            SqlParameter param3 = new SqlParameter("@UserId", SqlDbType.Int);
            //@UserId aka cust_id
            param3.Direction = ParameterDirection.ReturnValue;
            param3.IsNullable = true;
            cmd.Parameters.Add(param3);

            cmd.ExecuteScalar();
            cmd.Dispose();

            if ((int)param3.Value == 0)
            {
                param3.Value = null;
            }

            //return the cust_id from the customer table if successful
            return (int?)param3.Value;
        }

        public int? LoginRegisteredUser(string EmailAddress, string password)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_LoginRegisteredUser", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@EmailAddress", SqlDbType.VarChar);
            param1.Value = EmailAddress;
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@PasswordHash", SqlDbType.Char, 32);
            param2.Value = EncodePassword(password);
            cmd.Parameters.Add(param2);

            SqlParameter param3 = new SqlParameter("@UserId", SqlDbType.Int);
            //@UserId aka cust_id
            param3.Direction = ParameterDirection.ReturnValue;
            param3.IsNullable = true;
            cmd.Parameters.Add(param3);

            cmd.ExecuteScalar();
            cmd.Dispose();

            if ((int)param3.Value == 0)
            {
                param3.Value = null;
            }

            //return the user_id from the registration table if successful
            return (int?)param3.Value;
        }

        public int UpdatePassword(int cust_id, string password, string newpassword, string confirmpassword)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_UpdatePassword", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param0 = new SqlParameter("@cust_id", SqlDbType.Int);
            param0.Value = cust_id;
            cmd.Parameters.Add(param0);

            SqlParameter param1 = new SqlParameter("@PasswordHash", SqlDbType.Char, 32);
            param1.Value = EncodePassword(password);
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@NewPasswordHash", SqlDbType.Char, 32);
            param2.Value = EncodePassword(newpassword);
            cmd.Parameters.Add(param2);

            SqlParameter param3 = new SqlParameter("@ConfirmPasswordHash", SqlDbType.Char, 32);
            param3.Value = EncodePassword(confirmpassword);
            cmd.Parameters.Add(param3);

            SqlParameter param4 = new SqlParameter("@Return", SqlDbType.Int);
            param4.Direction = ParameterDirection.ReturnValue;
            param4.IsNullable = true;
            cmd.Parameters.Add(param4);

            cmd.ExecuteScalar();
            cmd.Dispose();

            return (int)param4.Value;
        }

        public int UpdateAccount(int customerId, string emailAddress, string companyName, string firstName, string lastName, bool receiveEmail)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_UpdateWebAccount", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param0 = new SqlParameter("@CustId", SqlDbType.Int);
            param0.Value = customerId;
            cmd.Parameters.Add(param0);

            SqlParameter param1 = new SqlParameter("@EmailAddress", SqlDbType.VarChar);
            param1.Value = emailAddress;
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@CompanyName", SqlDbType.Char, 60);
            param2.Value = String.IsNullOrEmpty(companyName.Trim()) ? firstName + " " + lastName : companyName.Trim();
            cmd.Parameters.Add(param2);

            SqlParameter param4 = new SqlParameter("@ErrorCode", SqlDbType.Int);
            param4.Direction = ParameterDirection.ReturnValue;
            param4.IsNullable = false;
            cmd.Parameters.Add(param4);

            SqlParameter param5 = new SqlParameter("@ReceiveEmail", SqlDbType.Bit);
            param5.Value = (receiveEmail) ? 1 : 0;
            cmd.Parameters.Add(param5);

            SqlParameter param6 = new SqlParameter("@FirstName", SqlDbType.Char, 60);
            param6.Value = firstName;
            cmd.Parameters.Add(param6);

            SqlParameter param7 = new SqlParameter("@LastName", SqlDbType.Char, 60);
            param7.Value = lastName;
            cmd.Parameters.Add(param7);


            SqlParameter param8 = new SqlParameter("@CustSortCode", SqlDbType.Char, 60);
            if (String.IsNullOrEmpty(companyName.Trim()))
            {
                param8.Value = lastName.Trim().Substring(0, Math.Min(lastName.Trim().Length, 7)).ToUpper() + firstName.Trim()[0].ToString().ToUpper();
            }
            else
            {
                param8.Value = companyName.Trim().Substring(0, Math.Min(companyName.Trim().Length, 8)).ToUpper();
            }

            cmd.Parameters.Add(param8);

            cmd.ExecuteScalar();
            cmd.Dispose();

            return (int)param4.Value;
        }

        public bool ForgotPassword(string emailAddress, string newPassword)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_ForgotPassword", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@EmailAddress", SqlDbType.VarChar);
            param1.Value = emailAddress;
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@TempPasswordHash", SqlDbType.Char, 32);
            param2.Value = EncodePassword(newPassword);
            cmd.Parameters.Add(param2);

            SqlParameter param4 = new SqlParameter("@UserExists", SqlDbType.Bit);
            param4.Direction = ParameterDirection.ReturnValue;
            param4.IsNullable = false;
            cmd.Parameters.Add(param4);

            cmd.ExecuteScalar();
            cmd.Dispose();

            return (int)param4.Value == 1;
        }

        public int UpdateRegisteredUser(string Reference, string EmailAddress,
            string CompanyName, string Address1, string Address2, string City, string State,
            string ZIP, string Country, string Phone, string FAX,
            bool ReceiveEmail, string AccountType, string FirstName, string LastName,
            string productsList, string speciesList, string servicesList, string tagline, string about, string website, int userid)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_UpdateRegisteredUser", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@EmailAddress", SqlDbType.VarChar);
            param1.Value = EmailAddress;
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@FirstName", SqlDbType.VarChar);
            param2.Value = FirstName;
            cmd.Parameters.Add(param2);

            SqlParameter param3 = new SqlParameter("@LastName", SqlDbType.VarChar);
            param3.Value = LastName;
            cmd.Parameters.Add(param3);

            SqlParameter param4 = new SqlParameter("@CompanyName", SqlDbType.VarChar);
            param4.Value = String.IsNullOrEmpty(CompanyName.Trim()) ? FirstName + " " + LastName : CompanyName.Trim();
            cmd.Parameters.Add(param4);

            SqlParameter param5 = new SqlParameter("@Address1", SqlDbType.VarChar);
            param5.Value = String.IsNullOrEmpty(Address1.Trim()) ? " " : Address1.Trim();
            cmd.Parameters.Add(param5);

            SqlParameter param6 = new SqlParameter("@Address2", SqlDbType.VarChar);
            param6.Value = String.IsNullOrEmpty(Address2.Trim()) ? " " : Address2.Trim();
            cmd.Parameters.Add(param6);

            SqlParameter param7 = new SqlParameter("@City", SqlDbType.VarChar);
            param7.Value = String.IsNullOrEmpty(City.Trim()) ? " " : City.Trim();
            cmd.Parameters.Add(param7);

            SqlParameter param8 = new SqlParameter("@State", SqlDbType.VarChar);
            param8.Value = String.IsNullOrEmpty(State.Trim()) ? " " : State.Trim();
            cmd.Parameters.Add(param8);

            SqlParameter param9 = new SqlParameter("@ZIP", SqlDbType.VarChar);
            param9.Value = String.IsNullOrEmpty(ZIP.Trim()) ? " " : ZIP.Trim();
            cmd.Parameters.Add(param9);

            SqlParameter param10 = new SqlParameter("@Country", SqlDbType.VarChar);
            param10.Value = String.IsNullOrEmpty(Country.Trim()) ? " " : Country.Trim();
            cmd.Parameters.Add(param10);

            SqlParameter param11 = new SqlParameter("@Phone", SqlDbType.VarChar);
            param11.Value = String.IsNullOrEmpty(Phone.Trim()) ? " " : Phone.Trim();
            cmd.Parameters.Add(param11);

            SqlParameter param12 = new SqlParameter("@FAX", SqlDbType.VarChar);
            param12.Value = String.IsNullOrEmpty(FAX.Trim()) ? " " : FAX.Trim();
            cmd.Parameters.Add(param12);

            SqlParameter param13 = new SqlParameter("@Website", SqlDbType.VarChar);
            param13.Value = String.IsNullOrEmpty(website.Trim()) ? " " : website.Trim();
            cmd.Parameters.Add(param13);

            SqlParameter param23 = new SqlParameter("@Products", SqlDbType.VarChar);
            param23.Value = String.IsNullOrEmpty(productsList.Trim()) ? " " : productsList.Trim();
            cmd.Parameters.Add(param23);

            SqlParameter param14 = new SqlParameter("@Species", SqlDbType.VarChar);
            param14.Value = String.IsNullOrEmpty(speciesList.Trim()) ? " " : speciesList.Trim();
            cmd.Parameters.Add(param14);

            SqlParameter param15 = new SqlParameter("@Services", SqlDbType.VarChar);
            param15.Value = String.IsNullOrEmpty(servicesList.Trim()) ? " " : servicesList.Trim();
            cmd.Parameters.Add(param15);

            SqlParameter param16 = new SqlParameter("@Tagline", SqlDbType.VarChar);
            param16.Value = String.IsNullOrEmpty(tagline.Trim()) ? " " : tagline.Trim();
            cmd.Parameters.Add(param16);

            SqlParameter param17 = new SqlParameter("@About", SqlDbType.VarChar);
            param17.Value = String.IsNullOrEmpty(about.Trim()) ? " " : about.Trim();
            cmd.Parameters.Add(param17);

            SqlParameter param19 = new SqlParameter("@ReceiveEmail", SqlDbType.Bit);
            param19.Value = (ReceiveEmail) ? 1 : 0;
            cmd.Parameters.Add(param19);

            SqlParameter param20 = new SqlParameter("@AccountType", SqlDbType.Int);
            param20.Value = AccountType;
            cmd.Parameters.Add(param20);

            SqlParameter param21 = new SqlParameter("@Referral", SqlDbType.VarChar);
            param21.Value = Reference;
            cmd.Parameters.Add(param21);

            SqlParameter param22 = new SqlParameter("@UserId", SqlDbType.Int);
            param22.Value = userid;
            cmd.Parameters.Add(param22);

            SqlParameter param24 = new SqlParameter("@ErrorCode", SqlDbType.Int);
            param24.Direction = ParameterDirection.ReturnValue;
            param24.IsNullable = false;
            cmd.Parameters.Add(param24);

            cmd.ExecuteScalar();
            cmd.Dispose();

            return (int)param24.Value;
        }
        
        public int CreateAccount(string Reference, string EmailAddress, string password,
            string CompanyName, string Address1, string Address2, string City, string State,
            string ZIP, string Country, string Phone, string FAX,
            bool ReceiveEmail, string AccountType, string FirstName, string LastName,
            string productsList, string speciesList, string servicesList, string tagline, string about, string website)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_CreateRegisteredUser", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@EmailAddress", SqlDbType.VarChar);
            param1.Value = EmailAddress;
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@FirstName", SqlDbType.VarChar);
            param2.Value = FirstName;
            cmd.Parameters.Add(param2);

            SqlParameter param3 = new SqlParameter("@LastName", SqlDbType.VarChar);
            param3.Value = LastName;
            cmd.Parameters.Add(param3);

            SqlParameter param4 = new SqlParameter("@CompanyName", SqlDbType.VarChar);
            param4.Value = String.IsNullOrEmpty(CompanyName.Trim()) ? FirstName + " " + LastName : CompanyName.Trim();
            cmd.Parameters.Add(param4);

            SqlParameter param5 = new SqlParameter("@Address1", SqlDbType.VarChar);
            param5.Value = String.IsNullOrEmpty(Address1.Trim()) ? " " : Address1.Trim();
            cmd.Parameters.Add(param5);

            SqlParameter param6 = new SqlParameter("@Address2", SqlDbType.VarChar);
            param6.Value = String.IsNullOrEmpty(Address2.Trim()) ? " " : Address2.Trim();
            cmd.Parameters.Add(param6);

            SqlParameter param7 = new SqlParameter("@City", SqlDbType.VarChar);
            param7.Value = String.IsNullOrEmpty(City.Trim()) ? " " : City.Trim();
            cmd.Parameters.Add(param7);

            SqlParameter param8 = new SqlParameter("@State", SqlDbType.VarChar);
            param8.Value = String.IsNullOrEmpty(State.Trim()) ? " " : State.Trim();
            cmd.Parameters.Add(param8);

            SqlParameter param9 = new SqlParameter("@ZIP", SqlDbType.VarChar);
            param9.Value = String.IsNullOrEmpty(ZIP.Trim()) ? " " : ZIP.Trim();
            cmd.Parameters.Add(param9);

            SqlParameter param10 = new SqlParameter("@Country", SqlDbType.VarChar);
            param10.Value = String.IsNullOrEmpty(Country.Trim()) ? " " : Country.Trim();
            cmd.Parameters.Add(param10);

            SqlParameter param11 = new SqlParameter("@Phone", SqlDbType.VarChar);
            param11.Value = String.IsNullOrEmpty(Phone.Trim()) ? " " : Phone.Trim();
            cmd.Parameters.Add(param11);

            SqlParameter param12 = new SqlParameter("@FAX", SqlDbType.VarChar);
            param12.Value = String.IsNullOrEmpty(FAX.Trim()) ? " " : FAX.Trim();
            cmd.Parameters.Add(param12);

            SqlParameter param13 = new SqlParameter("@Website", SqlDbType.VarChar);
            param13.Value = String.IsNullOrEmpty(website.Trim()) ? " " : website.Trim();
            cmd.Parameters.Add(param13);

            SqlParameter param23 = new SqlParameter("@Products", SqlDbType.VarChar);
            param23.Value = String.IsNullOrEmpty(productsList.Trim()) ? " " : productsList.Trim();
            cmd.Parameters.Add(param23);

            SqlParameter param14 = new SqlParameter("@Species", SqlDbType.VarChar);
            param14.Value = String.IsNullOrEmpty(speciesList.Trim()) ? " " : speciesList.Trim();
            cmd.Parameters.Add(param14);

            SqlParameter param15 = new SqlParameter("@Services", SqlDbType.VarChar);
            param15.Value = String.IsNullOrEmpty(servicesList.Trim()) ? " " : servicesList.Trim();
            cmd.Parameters.Add(param15);

            SqlParameter param16 = new SqlParameter("@Tagline", SqlDbType.VarChar);
            param16.Value = String.IsNullOrEmpty(tagline.Trim()) ? " " : tagline.Trim();
            cmd.Parameters.Add(param16);

            SqlParameter param17 = new SqlParameter("@About", SqlDbType.VarChar);
            param17.Value = String.IsNullOrEmpty(about.Trim()) ? " " : about.Trim();
            cmd.Parameters.Add(param17);

            SqlParameter param18 = new SqlParameter("@PasswordHash", SqlDbType.Char, 32);
            param18.Value = EncodePassword(password);
            cmd.Parameters.Add(param18);

            SqlParameter param19 = new SqlParameter("@ReceiveEmail", SqlDbType.Bit);
            param19.Value = (ReceiveEmail) ? 1 : 0;
            cmd.Parameters.Add(param19);

            SqlParameter param20 = new SqlParameter("@AccountType", SqlDbType.Int);
            param20.Value = AccountType;
            cmd.Parameters.Add(param20);

            SqlParameter param21 = new SqlParameter("@Referral", SqlDbType.VarChar);
            param21.Value = Reference;
            cmd.Parameters.Add(param21);

            SqlParameter param22 = new SqlParameter("@UserId", SqlDbType.Int);
            param22.Direction = ParameterDirection.ReturnValue;
            param22.IsNullable = false;
            cmd.Parameters.Add(param22);

            cmd.ExecuteScalar();
            cmd.Dispose();

            return (int)param22.Value;
        }

        public Registrations.registered_usersDataTable GetRegisteredUser(int user_id)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetRegisteredUser", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            Registrations.registered_usersDataTable ut = new Registrations.registered_usersDataTable();

            SqlParameter param = new SqlParameter("@user_id", SqlDbType.Int);
            param.Value = user_id;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(ut);
            cmd.Dispose();

            return ut;
        }

        public string EncodePassword(string originalPassword)
        {
            //Declarations
            Byte[] originalBytes;
            Byte[] encodedBytes;
            MD5 md5;

            //Instantiate MD5CryptoServiceProvider, get bytes for original password and compute hash (encoded password)
            md5 = new MD5CryptoServiceProvider();
            originalBytes = ASCIIEncoding.Default.GetBytes(originalPassword);
            encodedBytes = md5.ComputeHash(originalBytes);

            //Convert encoded bytes back to a 'readable' string
            return BitConverter.ToString(encodedBytes).Replace("-", "");
        }

        public string[] GetStates()
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetStates", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            da.Dispose();
            cmd.Dispose();

            List<String> states = new List<string>();

            foreach (DataRow dr in dt.Rows)
            {
                states.Add(dr["State"].ToString());
            }

            return states.ToArray();
        }

        public decimal GetStateSalesTax(string state, int custid)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetStateSalesTax", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@State", SqlDbType.Char);
            param1.Value = state;
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@custid", SqlDbType.Int);
            param2.Value = custid;
            cmd.Parameters.Add(param2);

            SqlParameter param3 = new SqlParameter("@TaxRate", SqlDbType.Decimal);
            param3.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(param3);

            cmd.ExecuteScalar();
            cmd.Dispose();

            return (decimal)param3.Value;
        }

        public CheckoutTables.AddressDataTable GetPreviousAddresses(int UserId)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetAddresses", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@UserId", SqlDbType.Int);
            param1.Value = UserId;
            cmd.Parameters.Add(param1);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            CheckoutTables.AddressDataTable adt = new CheckoutTables.AddressDataTable();

            adt.AddAddressRow(-1, -1, "", "", "", "", "", "", "", "", "");

            da.Fill(adt);
            da.Dispose();
            cmd.Dispose();

            return adt;
        }

        public CheckoutTables.OrderRow CreateOrder(Guid CartId, int LoginId)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_CreateWebOrder", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@CartId", SqlDbType.UniqueIdentifier);
            param1.Value = CartId;
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@UserId", SqlDbType.Int);
            param2.Value = LoginId;
            cmd.Parameters.Add(param2);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            CheckoutTables.OrderDataTable odt = new CheckoutTables().Order;

            da.Fill(odt);
            da.Dispose();
            cmd.Dispose();

            return (CheckoutTables.OrderRow)odt.Rows[0];
        }

        public CheckoutTables.OrderRow SaveOrder(CheckoutTables.OrderRow m_Order)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_SaveWebOrder", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param = new SqlParameter("@OrderId", SqlDbType.Int);
            param.Value = m_Order.OrderId;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@CustomerId", SqlDbType.Int);
            param.Value = m_Order.CustomerId;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@AddressId", SqlDbType.Int);
            param.Value = m_Order.IsAddressIdNull() ? DBNull.Value : (object)m_Order.AddressId;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@BillingAddressId", SqlDbType.Int);
            param.Value = m_Order.IsBillingAddressIdNull() ? DBNull.Value : (object)m_Order.BillingAddressId;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@Status", SqlDbType.Char);
            param.Value = m_Order.Status;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@ShippingOption", SqlDbType.Int);
            param.Value = m_Order.IsShippingOptionNull() ? DBNull.Value : (object)m_Order.ShippingOption;
            cmd.Parameters.Add(param);

            //Steve 11/13/08, added new field for Referral code
            param = new SqlParameter("@ReferralCode", SqlDbType.Char, 50);
            param.Value = m_Order.IsReferralCodeNull() ? DBNull.Value : (object)m_Order.ReferralCode;
            cmd.Parameters.Add(param);

            //these only need to get filled for new addresses
            CheckoutTables.AddressRow ar = null;

            #region Shipping Address

            if (!m_Order.IsAddressIdNull())
            {
                ar = ((CheckoutTables)m_Order.Table.DataSet).Address.FindBycust_addr_id(m_Order.AddressId);
            }

            param = new SqlParameter("@custFirstName", SqlDbType.Char, 60);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_firstname;
            cmd.Parameters.Add(param);
            param = new SqlParameter("@custLastName", SqlDbType.Char, 60);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_lastname;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@custAddress1", SqlDbType.Char, 60);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_addr_1;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@custAddress2", SqlDbType.Char, 60);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_addr_2;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@custCity", SqlDbType.Char, 40);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_city;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@custState", SqlDbType.Char, 2);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_state;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@custZip", SqlDbType.Char, 16);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_zip;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@custPhone", SqlDbType.Char, 32);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_phone;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@custFax", SqlDbType.Char, 32);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_fax;
            cmd.Parameters.Add(param);
            #endregion

            ar = null;

            #region Billing Address

            if (!m_Order.IsBillingAddressIdNull())
            {
                ar = ((CheckoutTables)m_Order.Table.DataSet).Address.FindBycust_addr_id(m_Order.BillingAddressId);
            }

            param = new SqlParameter("@BillingFirstName", SqlDbType.Char, 60);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_firstname;
            cmd.Parameters.Add(param);
            param = new SqlParameter("@BillingLastName", SqlDbType.Char, 60);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_lastname;
            cmd.Parameters.Add(param);
            param = new SqlParameter("@BillingAddress1", SqlDbType.Char, 60);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_addr_1;
            cmd.Parameters.Add(param);
            param = new SqlParameter("@BillingAddress2", SqlDbType.Char, 60);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_addr_2;
            cmd.Parameters.Add(param);
            param = new SqlParameter("@BillingCity", SqlDbType.Char, 40);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_city;
            cmd.Parameters.Add(param);
            param = new SqlParameter("@BillingState", SqlDbType.Char, 2);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_state;
            cmd.Parameters.Add(param);
            param = new SqlParameter("@BillingZip", SqlDbType.Char, 16);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_zip;
            cmd.Parameters.Add(param);
            param = new SqlParameter("@BillingPhone", SqlDbType.Char, 32);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_phone;
            cmd.Parameters.Add(param);
            param = new SqlParameter("@BillingFax", SqlDbType.Char, 32);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_fax;
            cmd.Parameters.Add(param);

            #endregion

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            CheckoutTables.OrderDataTable odt = new CheckoutTables().Order;

            da.Fill(odt);
            da.Dispose();
            cmd.Dispose();

            return (CheckoutTables.OrderRow)odt.Rows[0];
        }

        public void SetExpressCheckoutToken(CheckoutTables.OrderRow m_Order, string Token)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_InsertExpressToken", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param = new SqlParameter("@OrderId", SqlDbType.Int);
            param.Value = m_Order.OrderId;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@CartId", SqlDbType.UniqueIdentifier);
            param.Value = m_Order.CartId;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@token", SqlDbType.VarChar);
            param.Value = Token;
            cmd.Parameters.Add(param);

            cmd.ExecuteScalar();
            cmd.Dispose();
        }

        public CheckoutTables.OrderRow GetOrderFromExpressToken(string Token)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetExpressToken", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param = new SqlParameter("@token", SqlDbType.VarChar);
            param.Value = Token;
            cmd.Parameters.Add(param);

            SqlDataAdapter d = new SqlDataAdapter(cmd);
            CheckoutTables.OrderDataTable result = new CheckoutTables().Order;
            d.Fill(result);

            d.Dispose();
            cmd.Dispose();

            return result.Rows.Count > 0 ? (CheckoutTables.OrderRow)result.Rows[0] : null;
        }

        public CheckoutTables.OrderRow GetOrderByOrderID(int OrderID)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("[SP_GetOrderByOrderID]", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param = new SqlParameter("@OrderID", SqlDbType.Int);
            param.Value = OrderID;
            cmd.Parameters.Add(param);

            SqlDataAdapter d = new SqlDataAdapter(cmd);
            CheckoutTables.OrderDataTable result = new CheckoutTables().Order;
            d.Fill(result);

            d.Dispose();
            cmd.Dispose();

            return result.Rows.Count > 0 ? (CheckoutTables.OrderRow)result.Rows[0] : null;

        }

        private ShippingOption[] ParseShippingOptions(XmlDocument response)
        {
            if (response.DocumentElement["StatusCode"].InnerText.Trim() != "0")
            {
                EventLog.WriteEntry("WebUI Shipping Option retrieval", response.DocumentElement["StatusMessage"].InnerText, EventLogEntryType.Error);

                return null;
            }

            List<ShippingOption> options = new List<ShippingOption>();

            foreach (XmlElement pricesheet in response.DocumentElement["PriceSheets"].GetElementsByTagName("PriceSheet"))
            {
                string name = pricesheet["CarrierName"].InnerText + " " + pricesheet["Service"].InnerText;
                string description = "Shipping service through " + pricesheet["CarrierName"].InnerText + " as a " +
                    pricesheet["Service"].InnerText + " shipment, taking " + pricesheet["ServiceDays"].InnerText + " days with a total distance of " +
                    pricesheet["Distance"].InnerText + " miles";
                decimal cost = Decimal.Parse(pricesheet["Total"].InnerText);

                options.Add(new ShippingOption(0, name, description, cost));
            }

            //now add a customer pick up option and free samples

            options.Add(new ShippingOption(0, "FREE! Samples Only", "Samples ship FREE!<br />Please select this option for samples.", 0));
            options.Add(new ShippingOption(1, "Customer Will Call", "Will Call requires 48 hour notice.<br />Please call for pick up location.", 0));

            // sort
            options.Sort(new ShippingOptionComparer());

            //set optionids
            for (int i = 0; i < options.Count; ++i)
                options[i].OptionId = i;

            //return
            return options.ToArray();
        }

        private ShippingOption[] NoShippingOptions(CheckoutTables.OrderRow order)
        {

            List<ShippingOption> options = new List<ShippingOption>();

            options.Add(new ShippingOption(0, "Customer Will Call",
                "Our shipping quote system is down. You can arrange your own freight. Please call us to get the pick up location for your order. We have warehouses throughout the US but not all brands and products are stocked at all warehouses. Our customer service team will be glad to help you out in any way we can.",
                0));
            options.Add(new ShippingOption(1, "Please Arrange Shipping",
                "Our shipping quote system is down. We can arrange shipping for you. Please call for a quote. We have excellent freight rates with many different carriers throughout the US. Because this is a heavy shipment, we will need to quote you a spot rate. Please call us for details. You may continue the checkout process and freight will be billed separately.",
                0));

            // sort
            options.Sort(new ShippingOptionComparer());

            //set optionids
            for (int i = 0; i < options.Count; ++i)
                options[i].OptionId = i;

            //return
            return options.ToArray();
        }
        
        private ShippingOption[] HeavyShippingOptions(CheckoutTables.OrderRow order)
        {

            List<ShippingOption> options = new List<ShippingOption>();

            options.Add(new ShippingOption(0, "Customer Will Call", 
                "This order is over 20,000 pounds. You can arrange your own freight. Please call us to get the pick up location for your order. We have warehouses throughout the US but not all brands and products are stocked at all warehouses. Our customer service team will be glad to help you out in any way we can.",
                0));
            options.Add(new ShippingOption(1, "Please Arrange Shipping", 
                "This order is over 20,000 pounds. We can arrange shipping for you. Please call for a quote. We have excellent freight rates with many different carriers throughout the US. Because this is a heavy shipment, we will need to quote you a spot rate. Please call us for details. You may continue the checkout process and freight will be billed separately.",
                0));

            // sort
            options.Sort(new ShippingOptionComparer());

            //set optionids
            for (int i = 0; i < options.Count; ++i)
                options[i].OptionId = i;

            //return
            return options.ToArray();
        }

        public ShippingOption GetLowShippingOption(int prod_id, double weight, string destzip, int residential)
        {
            ShippingOption[] myShippingOptions;

            if (System.Configuration.ConfigurationManager.AppSettings["shippingSystemDown"] == "yes")
            {
                return new ShippingOption(0, "Shipping name", "Shipping description", 0);
            }

            XmlDocument request = new XmlDocument();
            XmlElement root = request.CreateElement("RateRequest");
            request.AppendChild(root);
            XmlElement Constraints = request.CreateElement("Constraints");
            Constraints.AppendChild(request.CreateElement("Contract"));
            Constraints.AppendChild(request.CreateElement("Carrier"));
            Constraints.AppendChild(request.CreateElement("Mode"));

            //Service Flags are within Constraints XML Element
            XmlElement ServiceFlags = request.CreateElement("ServiceFlags");
            if (residential == 1)
            {
                XmlElement ServiceFlag = request.CreateElement("ServiceFlag");
                XmlAttribute code = request.CreateAttribute("code");
                code.Value = "RES2";
                ServiceFlag.Attributes.Append(code);
                ServiceFlags.AppendChild(ServiceFlag);
            }
            Constraints.AppendChild(ServiceFlags);

            root.AppendChild(Constraints);
            
            //Items listing
            XmlElement Items = request.CreateElement("Items");
            root.AppendChild(Items);

            XmlElement Item = request.CreateElement("Item");
            XmlAttribute clsequence = request.CreateAttribute("sequence");
            XmlAttribute freightClass = request.CreateAttribute("freightClass");

            clsequence.Value = "2";
            freightClass.Value = "55";

            Item.Attributes.Append(clsequence);
            Item.Attributes.Append(freightClass);

            XmlElement Weight = request.CreateElement("Weight");
            Weight.InnerText = Convert.ToInt32(weight).ToString();
            XmlAttribute units = request.CreateAttribute("units");
            units.Value = "lb";
            Weight.Attributes.Append(units);
            Item.AppendChild(Weight);

            Items.AppendChild(Item);

            XmlElement Events = request.CreateElement("Events");
            root.AppendChild(Items);

            //From
            XmlElement pickupEvent = request.CreateElement("Event");
            XmlAttribute sequence = request.CreateAttribute("sequence");
            XmlAttribute type = request.CreateAttribute("type");
            XmlAttribute date = request.CreateAttribute("date");

            sequence.Value = "1";
            type.Value = "Pickup";
            date.Value = DateTime.Now.Add(TimeSpan.Parse(System.Configuration.ConfigurationManager.AppSettings["ShippingPickupDelay"])).ToString("M/d/yyyy H:mm");

            pickupEvent.Attributes.Append(sequence);
            pickupEvent.Attributes.Append(type);
            pickupEvent.Attributes.Append(date);

            XmlElement Location = request.CreateElement("Location");
            XmlElement City = request.CreateElement("City");
            XmlElement State = request.CreateElement("State");
            XmlElement Zip = request.CreateElement("Zip");
            XmlElement Country = request.CreateElement("Country");

            //get shipping point based on supplied dest zip
            string destState = GetState(destzip);

            DataTable ds = new DataTable();

            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetStateShippingPoint", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param = new SqlParameter("@State", SqlDbType.Char, 2);
            param.Value = destState;
            cmd.Parameters.Add(param);

            SqlParameter param2 = new SqlParameter("@Prod_id", SqlDbType.Int);
            param2.Value = prod_id;
            cmd.Parameters.Add(param2);

            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                da.Fill(ds);
            }

            City.InnerText = ds.Rows[0]["City"].ToString();
            State.InnerText = ds.Rows[0]["State"].ToString();
            Zip.InnerText = ds.Rows[0]["Zip"].ToString();
            Country.InnerText = ds.Rows[0]["Country"].ToString();

            Location.AppendChild(City);
            Location.AppendChild(State);
            Location.AppendChild(Zip);
            Location.AppendChild(Country);
            pickupEvent.AppendChild(Location);

            Events.AppendChild(pickupEvent);

            //To
            XmlElement dropEvent = request.CreateElement("Event");
            sequence = request.CreateAttribute("sequence");
            type = request.CreateAttribute("type");
            date = request.CreateAttribute("date");

            sequence.Value = "2";
            type.Value = "Drop";
            date.Value = DateTime.Now.Add(TimeSpan.Parse(
                System.Configuration.ConfigurationManager.AppSettings["ShippingDropDelay"])).ToString("M/d/yyyy H:mm");

            dropEvent.Attributes.Append(sequence);
            dropEvent.Attributes.Append(type);
            dropEvent.Attributes.Append(date);

            Location = request.CreateElement("Location");
            City = request.CreateElement("City");
            State = request.CreateElement("State");
            Zip = request.CreateElement("Zip");
            Country = request.CreateElement("Country");

            City.InnerText = GetCity( destzip );
            State.InnerText = destState;
            Zip.InnerText = destzip.ToString();
            Country.InnerText = "USA";

            Location.AppendChild(City);
            Location.AppendChild(State);
            Location.AppendChild(Zip);
            Location.AppendChild(Country);
            dropEvent.AppendChild(Location);

            Events.AppendChild(dropEvent);

            root.AppendChild(Events);

            try
            {
                HttpWebRequest httpRequest = (HttpWebRequest)WebRequest.Create(System.Configuration.ConfigurationManager.AppSettings["ShippingPostSite"]);

                string postData = "userid=" + System.Web.HttpUtility.UrlEncode(System.Configuration.ConfigurationManager.AppSettings["ShippingUsername"]);
                postData += "&password=" + System.Web.HttpUtility.UrlEncode(System.Configuration.ConfigurationManager.AppSettings["ShippingPassword"]);
                postData += "&request=" + System.Web.HttpUtility.UrlEncode(request.OuterXml);

                byte[] postDataBytes = Encoding.UTF8.GetBytes(postData);
                httpRequest.Method = "POST";
                httpRequest.ContentType = "application/x-www-form-urlencoded";
                httpRequest.ContentLength = postDataBytes.Length;
                Stream requestStream = httpRequest.GetRequestStream();
                requestStream.Write(postDataBytes, 0, postDataBytes.Length);
                requestStream.Close();

                HttpWebResponse resp = (HttpWebResponse)httpRequest.GetResponse();
                StreamReader responseReader = new StreamReader(resp.GetResponseStream(), Encoding.UTF8);
                string Response = responseReader.ReadToEnd();

                XmlDocument responseDoc = new XmlDocument();
                responseDoc.InnerXml = Response;

                myShippingOptions = ParseShippingOptions(responseDoc);

                if (myShippingOptions.Length > 1)
                {
                    if (myShippingOptions[2].Cost > 0)
                    {
                        // the first two (0,1) are free samples and will call - 2 is low cost option
                        return myShippingOptions[2];
                    }
                    else
                    {
                        return new ShippingOption(0, "Shipping name", "Shipping description", 0);
                    }
                }
                else
                {
                    return new ShippingOption(0, "Shipping name", "Shipping description", 0);
                }
            }
            catch
            {
                return new ShippingOption(0, "Shipping name", "Shipping description", 0);
            }
        }

        public ShippingOption[] GetShippingOptions(CheckoutTables.OrderRow order, int residential)
        {
            Cart.CartRow cart = GetCart(order.CartId, 0)._Cart.FindByCartId(order.CartId);

            if (cart == null || cart.ItemCount == 0 || order.IsAddressIdNull())
            {
                return null;
            }

            if (options.ContainsKey(cart.WeightTotal.ToString() + order.OrderId.ToString() + cart.ItemCount.ToString() + order.AddressId.ToString()))
            {
                return options[cart.WeightTotal.ToString() + order.OrderId.ToString() + cart.ItemCount.ToString() + order.AddressId.ToString()];
            }

            ShippingOption[] retval;

            if (cart.WeightTotal > 20000)
            {
                retval = HeavyShippingOptions(order);
            }
            else if (System.Configuration.ConfigurationManager.AppSettings["shippingSystemDown"] == "yes")
            {
                retval = NoShippingOptions(order);
            }
            else
            {
                try
                {
                    XmlDocument request = new XmlDocument();
                    XmlElement root = request.CreateElement("RateRequest");
                    request.AppendChild(root);
                    XmlElement Constraints = request.CreateElement("Constraints");
                    Constraints.AppendChild(request.CreateElement("Contract"));
                    Constraints.AppendChild(request.CreateElement("Carrier"));
                    Constraints.AppendChild(request.CreateElement("Mode"));

                    //Service Flags are within Constraints XML Element
                    XmlElement ServiceFlags = request.CreateElement("ServiceFlags");
                    if (residential == 1)
                    {
                        XmlElement ServiceFlag = request.CreateElement("ServiceFlag");
                        XmlAttribute code = request.CreateAttribute("code");
                        code.Value = "RES2";
                        ServiceFlag.Attributes.Append(code);
                        ServiceFlags.AppendChild(ServiceFlag);
                    }
                    Constraints.AppendChild(ServiceFlags);

                    root.AppendChild(Constraints);

                    //Items listing
                    XmlElement Items = request.CreateElement("Items");
                    root.AppendChild(Items);

                    int i = 1;
                    if (cart.GetCartLineRows().Length == 0)
                    {
                        return new ShippingOption[0];
                    }

                    foreach (Cart.CartLineRow cl in cart.GetCartLineRows())
                    {
                        ++i;
                        XmlElement Item = request.CreateElement("Item");
                        XmlAttribute clsequence = request.CreateAttribute("sequence");
                        XmlAttribute freightClass = request.CreateAttribute("freightClass");

                        clsequence.Value = i.ToString();
                        freightClass.Value = cl.FreightClass.ToString();

                        Item.Attributes.Append(clsequence);
                        Item.Attributes.Append(freightClass);

                        XmlElement Weight = request.CreateElement("Weight");
                        Weight.InnerText = cl.Weight.ToString();
                        XmlAttribute units = request.CreateAttribute("units");
                        units.Value = "lb";
                        Weight.Attributes.Append(units);
                        Item.AppendChild(Weight);

                        Items.AppendChild(Item);
                    }

                    XmlElement Events = request.CreateElement("Events");
                    root.AppendChild(Items);

                    //From
                    XmlElement pickupEvent = request.CreateElement("Event");
                    XmlAttribute sequence = request.CreateAttribute("sequence");
                    XmlAttribute type = request.CreateAttribute("type");
                    XmlAttribute date = request.CreateAttribute("date");

                    sequence.Value = "1";
                    type.Value = "Pickup";
                    date.Value = DateTime.Now.Add(TimeSpan.Parse(System.Configuration.ConfigurationManager.AppSettings["ShippingPickupDelay"])).ToString("M/d/yyyy H:mm");

                    pickupEvent.Attributes.Append(sequence);
                    pickupEvent.Attributes.Append(type);
                    pickupEvent.Attributes.Append(date);

                    XmlElement Location = request.CreateElement("Location");
                    XmlElement City = request.CreateElement("City");
                    XmlElement State = request.CreateElement("State");
                    XmlElement Zip = request.CreateElement("Zip");
                    XmlElement Country = request.CreateElement("Country");

                    DataTable ds = new DataTable();

                    this.OpenConnection();
                    SqlCommand cmd = new SqlCommand("SP_GetCartShippingPoint", DbConnection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter param = new SqlParameter("@CartId", SqlDbType.UniqueIdentifier);
                    param.Value = order.CartId;
                    cmd.Parameters.Add(param);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ds);
                    }

                    City.InnerText = ds.Rows[0]["City"].ToString();
                    State.InnerText = ds.Rows[0]["State"].ToString();
                    Zip.InnerText = ds.Rows[0]["Zip"].ToString();
                    Country.InnerText = ds.Rows[0]["Country"].ToString();

                    Location.AppendChild(City);
                    Location.AppendChild(State);
                    Location.AppendChild(Zip);
                    Location.AppendChild(Country);
                    pickupEvent.AppendChild(Location);

                    Events.AppendChild(pickupEvent);

                    //To
                    XmlElement dropEvent = request.CreateElement("Event");
                    sequence = request.CreateAttribute("sequence");
                    type = request.CreateAttribute("type");
                    date = request.CreateAttribute("date");

                    sequence.Value = "2";
                    type.Value = "Drop";
                    date.Value = DateTime.Now.Add(TimeSpan.Parse(
                        System.Configuration.ConfigurationManager.AppSettings["ShippingDropDelay"])).ToString("M/d/yyyy H:mm");

                    dropEvent.Attributes.Append(sequence);
                    dropEvent.Attributes.Append(type);
                    dropEvent.Attributes.Append(date);

                    Location = request.CreateElement("Location");
                    City = request.CreateElement("City");
                    State = request.CreateElement("State");
                    Zip = request.CreateElement("Zip");
                    Country = request.CreateElement("Country");

                    if (order.AddressId < 0)
                    {
                        return new ShippingOption[0];
                    }

                    CheckoutTables.AddressRow shippingAddress = this.GetPreviousAddresses(order.CustomerId).FindBycust_addr_id(order.AddressId);
                    City.InnerText = shippingAddress.cust_city;
                    State.InnerText = shippingAddress.cust_state;
                    Zip.InnerText = shippingAddress.cust_zip;
                    Country.InnerText = "USA";

                    Location.AppendChild(City);
                    Location.AppendChild(State);
                    Location.AppendChild(Zip);
                    Location.AppendChild(Country);
                    dropEvent.AppendChild(Location);

                    Events.AppendChild(dropEvent);

                    root.AppendChild(Events);

                    //old try started here

                    HttpWebRequest httpRequest = (HttpWebRequest)WebRequest.Create(System.Configuration.ConfigurationManager.AppSettings["ShippingPostSite"]);

                    string postData = "userid=" + System.Web.HttpUtility.UrlEncode(System.Configuration.ConfigurationManager.AppSettings["ShippingUsername"]);
                    postData += "&password=" + System.Web.HttpUtility.UrlEncode(System.Configuration.ConfigurationManager.AppSettings["ShippingPassword"]);
                    postData += "&request=" + System.Web.HttpUtility.UrlEncode(request.OuterXml);

                    byte[] postDataBytes = Encoding.UTF8.GetBytes(postData);
                    httpRequest.Method = "POST";
                    httpRequest.ContentType = "application/x-www-form-urlencoded";
                    httpRequest.ContentLength = postDataBytes.Length;
                    Stream requestStream = httpRequest.GetRequestStream();
                    requestStream.Write(postDataBytes, 0, postDataBytes.Length);
                    requestStream.Close();

                    HttpWebResponse resp = (HttpWebResponse)httpRequest.GetResponse();
                    StreamReader responseReader = new StreamReader(resp.GetResponseStream(), Encoding.UTF8);
                    string Response = responseReader.ReadToEnd();

                    XmlDocument responseDoc = new XmlDocument();
                    responseDoc.InnerXml = Response;

                    retval = ParseShippingOptions(responseDoc);

                    if (retval != null)
                    {
                        options[cart.WeightTotal.ToString() + order.OrderId.ToString() + cart.ItemCount.ToString() + order.AddressId.ToString()] = retval;
                    }
                    else
                    {
                        retval = new ShippingOption[0];
                    }
                }
                catch
                {
                    retval = NoShippingOptions(order);
                }
            }

            return retval;
        }

        public string GetState(string zip)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetState", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@zip", SqlDbType.Char, 5);
            param1.Value = zip;
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@state", SqlDbType.Char, 2);
            param2.Direction = ParameterDirection.Output;
            param2.IsNullable = false;
            cmd.Parameters.Add(param2);

            cmd.ExecuteScalar();
            cmd.Dispose();

            return param2.Value.ToString();
        }

        public string GetCity(string zip)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetCity", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@zip", SqlDbType.Char, 5);
            param1.Value = zip; 
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@city", SqlDbType.Char, 28);
            param2.Direction = ParameterDirection.Output;
            param2.IsNullable = false;
            cmd.Parameters.Add(param2);

            cmd.ExecuteScalar();
            cmd.Dispose();

            return param2.Value.ToString();
        }


        public object GetColors()
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetColors", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            Colors.colorsDataTable st = new Colors.colorsDataTable();

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(st);
            cmd.Dispose();

            return st;
        }

        public object GetTextures()
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetTextures", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            Textures.texturesDataTable st = new Textures.texturesDataTable();

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(st);
            cmd.Dispose();

            return st;
        }

        public RegionWeb.region_webDataTable GetRegionWeb()
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_WebGetRegionWeb", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            RegionWeb.region_webDataTable st = new RegionWeb.region_webDataTable();

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(st);
            cmd.Dispose();

            return st;
        }

        public RegionWeb.region_webDataTable GetOneRegionWeb(int region_web_id)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_WebGetOneRegionWeb", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            RegionWeb.region_webDataTable st = new RegionWeb.region_webDataTable();

            SqlParameter param = new SqlParameter("@region_web_id", SqlDbType.Int);
            param.Value = region_web_id;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(st);
            cmd.Dispose();

            return st;
        }

        public RegionWebFlooring.region_web_flooringDataTable GetRegionWebFlooring()
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_WebGetRegionFlooring", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            RegionWebFlooring.region_web_flooringDataTable st = new RegionWebFlooring.region_web_flooringDataTable();

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(st);
            cmd.Dispose();

            return st;
        }

        public RegionWebFlooring.region_web_flooringDataTable GetOneRegionWebFlooring(int region_web_id)
        {
            this.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_WebGetOneRegionFlooring", DbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            RegionWebFlooring.region_web_flooringDataTable st = new RegionWebFlooring.region_web_flooringDataTable();

            SqlParameter param = new SqlParameter("@region_web_id", SqlDbType.Int);
            param.Value = region_web_id;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(st);
            cmd.Dispose();

            return st;
        }
    }
}
