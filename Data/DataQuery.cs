using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Security.Cryptography;
using com.paypal.soap.api;
using System.Xml;
using System.Net;
using System.IO;
using System.Diagnostics;

namespace Data
{
    [Serializable]
    public class DataQuery
    {
        /// <summary>
        /// private constructor, sets up the sql connection, used through singleton
        /// </summary>

        private static SqlConnection _connection;
        /// <summary>
        /// The only SQL connection to be needed
        /// </summary>
        public static SqlConnection Connection
        {
            get
            {
                if (_connection == null)
                    _connection = 
                        new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["NovaDatabase"].ConnectionString);
                return _connection;
            }
        }
        /// <summary>
        /// Function to get the list of locations for the 'locations' page, from the database
        /// </summary>
        /// <returns>A Data.Locations dataset</returns>

        public static void OpenConnection()
        {
            if(Connection.State==ConnectionState.Broken)
            {
                Connection.Close();
                Connection.Open();
            }
            else if (Connection.State == ConnectionState.Closed)
            {
                Connection.Open();
            }
        }
        public static void CloseConnection()
        {
            if (Connection.State != ConnectionState.Closed)
                Connection.Close();
        }
        
        public static Locations GetLocationsList()
        {
            DataQuery.OpenConnection();
            SqlCommand cmd = new SqlCommand("", DataQuery.Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SP_GetWebLocations";
            Locations loc = new Locations();
            loc.EnforceConstraints = false;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.TableMappings.Add("Table","Category");
            da.TableMappings.Add("Table1", "Location");
            da.TableMappings.Add("Table2", "Hours");
            da.Fill(loc);
            loc.EnforceConstraints = true;
            cmd.Dispose();

            return loc;
        }

        public static ProductList.productsDataTable GetProductList()
        {
            return GetProductList(new SelectedFilter[0]);
        }

        public static ProductList.productsDataTable GetProductList(SelectedFilter[] selectedFilters)
        {
            return GetProductList(selectedFilters, "");
        }

        public static ProductList.productsDataTable GetProductList(SelectedFilter[] selectedFilters, string SrchText)
        {
            string CurrentFilters = "";
            foreach (SelectedFilter sf in selectedFilters)
            {
                if (!String.IsNullOrEmpty(CurrentFilters))
                    CurrentFilters += ',';
                CurrentFilters += sf.EntryId;
            }
            ProductList pl = new ProductList();
            pl.EnforceConstraints = false;
            DataQuery.OpenConnection();

            SqlCommand cmd = new SqlCommand("SP_GetWebProductsList", DataQuery.Connection);
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
            pl.EnforceConstraints = true;

            return pl.products;
        }
        public static CheckoutTables.OrderRow GetSubmittedOrder(int OrderId)
        {
            DataQuery.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetSubmittedOrder", DataQuery.Connection);
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
        public static Promotions.PromotionDataTable GetPromotions()
        {
            DataQuery.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetPromotions", DataQuery.Connection);
            cmd.CommandType = CommandType.StoredProcedure;

            Promotions.PromotionDataTable pdt = new Promotions.PromotionDataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(pdt);

            da.Dispose();
            cmd.Dispose();

            return pdt;
        }

        public static PromoBlocks.PromoBlockDataTable GetPromoBlocks()
        {
            DataQuery.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetPromoBlocks", DataQuery.Connection);
            cmd.CommandType = CommandType.StoredProcedure;

            PromoBlocks.PromoBlockDataTable pdt = new PromoBlocks.PromoBlockDataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(pdt);

            da.Dispose();
            cmd.Dispose();

            return pdt;
        }

        public static ProductPhotos.prodphotosDataTable GetProdPhotos(int ProductId)
        {
            DataQuery.OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetWebProductPhotos", DataQuery.Connection);
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

        public static ProductList.productsDataTable GetProductDetails(int ProductId)
        {
            DataQuery.OpenConnection();

            ProductList pl=new ProductList();

            SqlCommand cmd = new SqlCommand("SP_GetWebProductsDetails", DataQuery.Connection);
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

        public static Attributes.AttributeListingDataTable GetProductListAttributeListing()
        {
            return GetAttributeListing("ProductList");
        }
        public static Attributes.AttributeListingDataTable GetProductDetailsAttributeListing()
        {
            return GetAttributeListing("ProductDetails");
        }
        public static Attributes.AttributeListingDataTable GetAttributeListing(string PageType)
        {
            DataQuery.OpenConnection();
            Attributes.AttributeListingDataTable dt = new Attributes.AttributeListingDataTable();

            SqlCommand cmd = new SqlCommand("SP_GetWebAttributes", DataQuery.Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter param = new SqlParameter("@LocationName", SqlDbType.VarChar);
            param.Value = PageType;
            cmd.Parameters.Add(param);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            cmd.Dispose();
            return dt;
        }
        /// <summary>
        /// Gets the list of filters, with non already selected
        /// </summary>
        /// <returns></returns>
        public static void UpdateFilterCounts(FiltersDS current, SelectedFilter[] selectedFilters)
        {
            string CurrentFilters = "";
            foreach (SelectedFilter sf in selectedFilters)
            {
                if (!String.IsNullOrEmpty(CurrentFilters))
                    CurrentFilters += ',';
                CurrentFilters += sf.EntryId;
            }

            FiltersDS ds = new FiltersDS();
            ds.EnforceConstraints = false;
            DataQuery.OpenConnection();
            SqlCommand cmd = new SqlCommand("", DataQuery.Connection);
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
        
        public static FiltersDS GetFilters()
        {

            OpenConnection();
            FiltersDS ds = new FiltersDS();
            ds.EnforceConstraints = false;
            DataQuery.OpenConnection();
            SqlCommand cmd = new SqlCommand("", DataQuery.Connection);
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
        public static void SubmitOrder(int OrderId, decimal SubTotal, decimal taxCost, int ShippingOptionId, string ShippingOptionName,
     decimal ShippingCost, decimal Total)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_SetOrderSubmitted", DataQuery.Connection);
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
        public static Learn GetLearnAbout(int? NodeId)
        {
            OpenConnection();
            Learn learnDS = new Learn();
            learnDS.EnforceConstraints = false;

            SqlCommand cmd = new SqlCommand("SP_GetWebLearnAbout", DataQuery.Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            if (NodeId != null)//only add if it isn't null
            {
                SqlParameter param = new SqlParameter("@NodeId", SqlDbType.Int);
                param.Value = NodeId.Value;
                cmd.Parameters.Add(param);
            }
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.TableMappings.Add("Table", "LearnNodes");
            da.TableMappings.Add("Table1", "Documents");

            da.Fill(learnDS);
            cmd.Dispose();
            learnDS.EnforceConstraints = true ;
            return learnDS;
        }
        public static Cart GetClosedCart(Guid CartId)
        {
            OpenConnection();
            Cart cart = new Cart();
            cart.EnforceConstraints = false;

            SqlCommand cmd = new SqlCommand("SP_GetCart", DataQuery.Connection);
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

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.TableMappings.Add("Table", "Cart");
            da.TableMappings.Add("Table1", "CartLine");

            da.Fill(cart);
            cmd.Dispose();

            cart.EnforceConstraints = true;
            return cart;
        }
        public static Cart GetCart(Guid CartId)
        {
            OpenConnection();
            Cart cart= new Cart();
            cart.EnforceConstraints = false;

            SqlCommand cmd = new SqlCommand("SP_GetCart", DataQuery.Connection);
            cmd.CommandType = CommandType.StoredProcedure;
            if (CartId != null && CartId!=Guid.Empty)//only add if it isn't null
            {
                SqlParameter param = new SqlParameter("@CartId", SqlDbType.UniqueIdentifier);
                param.Value = CartId;
                cmd.Parameters.Add(param);
            }
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.TableMappings.Add("Table", "Cart");
            da.TableMappings.Add("Table1", "CartLine");

            da.Fill(cart);
            cmd.Dispose();

            cart.EnforceConstraints = true;
            return cart;
        }
        public static void AddItemToCart(Guid CartId, int ProductId,int Quantity)
        {
            if (CartId != Guid.Empty && Quantity > 0 && ProductId >= 0)
            {
                OpenConnection();
                SqlCommand cmd = new SqlCommand("SP_AddItemToCart", DataQuery.Connection);
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

                cmd.ExecuteScalar(); 
                cmd.Dispose();
            }
        }

        public static void SetCartStatus(Guid CartId, CartStatus cs)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_SetCartStatus", DataQuery.Connection);
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
        public static void UpdateItemQuantities(Guid CartId, int[] ProductIds, int[] Quantities)
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
                SqlCommand cmd = new SqlCommand("SP_UpdateCartItems", DataQuery.Connection);
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
        public static int? Login(string EmailAddress, string password)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetLogin", DataQuery.Connection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@EmailAddress", SqlDbType.VarChar);
            param1.Value = EmailAddress;
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@PasswordHash", SqlDbType.Char,32);
            param2.Value = EncodePassword(password);
            cmd.Parameters.Add(param2);

            SqlParameter param3 = new SqlParameter("@UserId", SqlDbType.Int);
            param3.Direction = ParameterDirection.ReturnValue;
            param3.IsNullable = true;
            cmd.Parameters.Add(param3);

            cmd.ExecuteScalar();
            cmd.Dispose();

            if ((int)param3.Value == 0)
                param3.Value = null;

            return (int?)param3.Value;
        }
        public static int CreateAccount(string EmailAddress,string password, string CompanyName,
            bool ReceiveEmail,string FirstName,string LastName)
        {
            //@FirstName char(60),
            //@LastName char(60),
            //@CustSortCode char(10)

            OpenConnection();
            SqlCommand cmd= new SqlCommand("SP_CreateWebAccount",DataQuery.Connection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@EmailAddress", SqlDbType.VarChar);
            param1.Value = EmailAddress;
            cmd.Parameters.Add(param1);

            SqlParameter param2 = new SqlParameter("@PasswordHash", SqlDbType.Char,32);
            param2.Value = EncodePassword(password);
            cmd.Parameters.Add(param2);

            SqlParameter param3 = new SqlParameter("@CompanyName", SqlDbType.Char,60);
            param3.Value = String.IsNullOrEmpty(CompanyName.Trim())?FirstName+" "+LastName:CompanyName.Trim();
            cmd.Parameters.Add(param3);

            SqlParameter param4 = new SqlParameter("@UserId", SqlDbType.Int);
            param4.Direction = ParameterDirection.ReturnValue;
            param4.IsNullable = false;
            cmd.Parameters.Add(param4);

            SqlParameter param5 = new SqlParameter("@ReceiveEmail", SqlDbType.Bit);
            param5.Value = (ReceiveEmail) ? 1 : 0;
            cmd.Parameters.Add(param5);

            SqlParameter param6 = new SqlParameter("@FirstName", SqlDbType.Char, 60);
            param6.Value = FirstName;
            cmd.Parameters.Add(param6);

            SqlParameter param7 = new SqlParameter("@LastName", SqlDbType.Char, 60);
            param7.Value = LastName;
            cmd.Parameters.Add(param7);

            SqlParameter param8 = new SqlParameter("@CustSortCode", SqlDbType.Char, 60);
            if(String.IsNullOrEmpty(CompanyName.Trim()))
            {
                param8.Value = LastName.Trim().Substring(0, Math.Min(LastName.Trim().Length, 7)).ToUpper() +
                    FirstName.Trim()[0].ToString().ToUpper();
            }
            else
            {
                param8.Value = CompanyName.Trim().Substring(0,Math.Min(CompanyName.Trim().Length,8)).ToUpper();
            }
            cmd.Parameters.Add(param8);

            cmd.ExecuteScalar();
            cmd.Dispose();

            //TODO: Handling of this value needs to be more robust. (Email is taken, etc.)
            return (int)param4.Value;
        }
        public static string EncodePassword(string originalPassword)
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
            return BitConverter.ToString(encodedBytes).Replace("-", ""); ;
        }
        public static string[] GetStates()
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetStates", DataQuery.Connection);
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
        public static decimal GetStateSalesTax(string state)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetStateSalesTax", DataQuery.Connection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@State", SqlDbType.Char);
            param1.Value = state;
            cmd.Parameters.Add(param1);

            param1 = new SqlParameter("@TaxRate", SqlDbType.Decimal);
            param1.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(param1);

            cmd.ExecuteScalar();
            cmd.Dispose();

            return (decimal)param1.Value;
        }
        public static CheckoutTables.AddressDataTable GetPreviousAddresses(int UserId)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetAddresses", DataQuery.Connection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@UserId", SqlDbType.Int);
            param1.Value = UserId;
            cmd.Parameters.Add(param1);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            CheckoutTables.AddressDataTable adt = new CheckoutTables.AddressDataTable();

            adt.AddAddressRow(-1, -1, "", "", "", "", "", "", "","","");

            da.Fill(adt);
            da.Dispose();
            cmd.Dispose();
            
            return adt;
        }
        public static CheckoutTables.OrderRow CreateOrder(Guid CartId, int LoginId)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_CreateWebOrder", DataQuery.Connection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter("@CartId",SqlDbType.UniqueIdentifier);
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
        public static CheckoutTables.OrderRow SaveOrder(CheckoutTables.OrderRow m_Order)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_SaveWebOrder", DataQuery.Connection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param = new SqlParameter("@OrderId", SqlDbType.Int);
            param.Value = m_Order.OrderId;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@CustomerId", SqlDbType.Int);
            param.Value = m_Order.CustomerId;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@AddressId", SqlDbType.Int);
            param.Value =m_Order.IsAddressIdNull()?DBNull.Value:(object) m_Order.AddressId;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@BillingAddressId", SqlDbType.Int);
            param.Value = m_Order.IsBillingAddressIdNull() ? DBNull.Value : (object)m_Order.BillingAddressId;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@Status", SqlDbType.Char);
            param.Value = m_Order.Status;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@ShippingOption", SqlDbType.Int);
            param.Value = m_Order.IsShippingOptionNull()?DBNull.Value :(object) m_Order.ShippingOption;
            cmd.Parameters.Add(param);

            //these only need to get filled for new addresses
            CheckoutTables.AddressRow ar=null;
            #region Shipping Address
            if(!m_Order.IsAddressIdNull())
                ar = ((CheckoutTables)m_Order.Table.DataSet).Address.FindBycust_addr_id(m_Order.AddressId);

            param = new SqlParameter("@custFirstName", SqlDbType.Char, 60);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_firstname;
            cmd.Parameters.Add(param);
            param = new SqlParameter("@custLastName", SqlDbType.Char, 60);
            param.Value = (ar == null) ? DBNull.Value : (object)ar.cust_lastname;
            cmd.Parameters.Add(param);

            param = new SqlParameter("@custAddress1", SqlDbType.Char, 60);
            param.Value = (ar == null) ? DBNull.Value :(object) ar.cust_addr_1;
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
            if(!m_Order.IsBillingAddressIdNull())
                ar = ((CheckoutTables)m_Order.Table.DataSet).Address.FindBycust_addr_id(m_Order.BillingAddressId);

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
            param = new SqlParameter("@BillingFax", SqlDbType.Char,32);
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
        public static void SetExpressCheckoutToken(Data.CheckoutTables.OrderRow m_Order, string Token)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_InsertExpressToken", DataQuery.Connection);
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
        public static CheckoutTables.OrderRow GetOrderFromExpressToken(string Token)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetExpressToken", DataQuery.Connection);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter param = new SqlParameter("@token", SqlDbType.VarChar);
            param.Value = Token;
            cmd.Parameters.Add(param);

            SqlDataAdapter d = new SqlDataAdapter(cmd);
            CheckoutTables.OrderDataTable result = new CheckoutTables().Order;
            d.Fill(result);

            d.Dispose();
            cmd.Dispose();

            return result.Rows.Count > 0 ? (CheckoutTables.OrderRow)result.Rows[0]: null;
        }

        public static CheckoutTables.OrderRow GetOrderByOrderID(int OrderID)
        {
            OpenConnection();
            SqlCommand cmd = new SqlCommand("[SP_GetOrderByOrderID]", DataQuery.Connection);
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

        private static string FindDataSetErrors(DataTable dt)
        {
            StringBuilder retval = new StringBuilder();

            if (dt.HasErrors)
            {
                retval.Append(dt.TableName);
                retval.Append(":\n");

                foreach (DataRow dr in dt.Rows)
                {
                    if (dr.HasErrors)
                    {
                        retval.Append("\t");
                        retval.Append(dr.RowError);
                        retval.Append(":");
                        retval.Append(dr.RowError);
                        retval.Append("\n");

                        foreach (DataColumn dc in dr.GetColumnsInError())
                        {
                            retval.Append("\t\t");
                            retval.Append(dc.ColumnName);
                            retval.Append(":");
                            retval.Append(dr.GetColumnError(dc));
                            retval.Append("\n");
                        }
                    }
                }

            }
            return retval.ToString();
        }
        private static string FindDataSetErrors(DataSet ds)
        {
            StringBuilder retval=new StringBuilder();
            foreach (DataTable dt in ds.Tables)
            {
                if (dt.HasErrors)
                {
                    retval.Append(dt.TableName);
                    retval.Append(":\n");

                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr.HasErrors)
                        {
                            retval.Append("\t");
                            retval.Append(dr.RowError);
                            retval.Append(":");
                            retval.Append(dr.RowError);
                            retval.Append("\n");

                            foreach (DataColumn dc in dr.GetColumnsInError())
                            {
                                retval.Append("\t\t");
                                retval.Append(dc.ColumnName);
                                retval.Append(":");
                                retval.Append(dr.GetColumnError(dc));
                                retval.Append("\n");
                            }
                        }
                    }
                }
            }
            return retval.ToString();
        }
        private static ShippingOption[] ParseShippingOptions(XmlDocument response)
        {
            if (response.DocumentElement["StatusCode"].InnerText.Trim() != "0")
            {
                EventLog.WriteEntry("WoodMonsters Shipping Option retrieval", response.DocumentElement["StatusMessage"].InnerText, EventLogEntryType.Error);

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


            //now add a customer pick up option
            options.Add(new ShippingOption(0, "Customer will call", " Requires 48 hour notice. Please call for pick up location. 888-448-9663", 0));


            // sort
            options.Sort(new ShippingOptionComparer());

            //set optionids
            for (int i = 0; i < options.Count; ++i)
                options[i].OptionId = i;

            //return
            return options.ToArray();
        }
        private static Dictionary<string, ShippingOption[]> options = new Dictionary<string, ShippingOption[]>();


        public static ShippingOption[] GetShippingOptions(Data.CheckoutTables.OrderRow order)
        {
            Cart.CartRow cart = GetCart(order.CartId)._Cart.FindByCartId(order.CartId);

            if (cart == null || cart.ItemCount == 0 || order.IsAddressIdNull())
            {
                return null;
            }

            if (options.ContainsKey(cart.WeightTotal.ToString() + order.OrderId.ToString() + cart.ItemCount.ToString() +
                order.AddressId.ToString()))
                return options[cart.WeightTotal.ToString() + order.OrderId.ToString() + cart.ItemCount.ToString() +
                    order.AddressId.ToString()];


            XmlDocument request = new XmlDocument();
            XmlElement root = request.CreateElement("RateRequest");
            request.AppendChild(root);
            XmlElement Constraints = request.CreateElement("Constraints");
            Constraints.AppendChild(request.CreateElement("Contract"));
            Constraints.AppendChild(request.CreateElement("Carrier"));
            Constraints.AppendChild(request.CreateElement("Mode"));
            Constraints.AppendChild(request.CreateElement("ServiceFlags"));
            root.AppendChild(Constraints);

            //Items listing
            XmlElement Items = request.CreateElement("Items");
            root.AppendChild(Items);


            int i = 1;
            if (cart.GetCartLineRows().Length == 0)
                return new ShippingOption[0];
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
            date.Value = DateTime.Now.Add(TimeSpan.Parse(
                System.Configuration.ConfigurationManager.AppSettings["ShippingPickupDelay"])).ToString("M/d/yyyy H:mm");

            pickupEvent.Attributes.Append(sequence);
            pickupEvent.Attributes.Append(type);
            pickupEvent.Attributes.Append(date);


            XmlElement Location = request.CreateElement("Location");
            XmlElement City = request.CreateElement("City");
            XmlElement State = request.CreateElement("State");
            XmlElement Zip = request.CreateElement("Zip");
            XmlElement Country = request.CreateElement("Country");


            DataTable ds = new DataTable();

            OpenConnection();
            SqlCommand cmd = new SqlCommand("SP_GetCartShippingPoint", Connection);
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
                return new ShippingOption[0];

            Data.CheckoutTables.AddressRow shippingAddress = DataQuery.GetPreviousAddresses(order.CustomerId).FindBycust_addr_id(order.AddressId);
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

            HttpWebRequest httpRequest =
                (HttpWebRequest)WebRequest.Create(System.Configuration.ConfigurationManager.AppSettings["ShippingPostSite"]);


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

            ShippingOption[] retval = ParseShippingOptions(responseDoc);

            if (retval != null)
            {
                options[cart.WeightTotal.ToString() + order.OrderId.ToString() + cart.ItemCount.ToString() +
                        order.AddressId.ToString()] = retval;
            }
            else
            {
                retval = new ShippingOption[0];
            }
            return retval;
        }
    }
    /// <summary>
    /// A struct to represent a selected filter
    /// </summary>
    [Serializable]
    public struct SelectedFilter
    {
        public SelectedFilter(int filterId, int entryId)
        {
            FilterId = filterId;
            EntryId = entryId;
        }
        public int FilterId;
        public int EntryId;
    }
    public enum CreateAccountErrorMessages
    {
        OtherError =-1,
        EmailTaken =-2
    }
    public enum CartStatus
    {
        New = 'N', Finalized = 'F', Submitted = 'S'
    }
}
