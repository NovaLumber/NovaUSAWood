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

namespace WebUI.Controls
{

    public partial class ShoppingCartPlugin : System.Web.UI.UserControl
    {
        protected global::System.Web.UI.HtmlControls.HtmlAnchor CartViewLink; 
        protected global::System.Web.UI.WebControls.Label ItemCount; 
        protected global::System.Web.UI.WebControls.Label OrderTotal;  

        protected Guid CartId;
        protected DataAccessLayer daLayer = new DataAccessLayer();
        public Cart Cart;

        int discount;
        decimal priceFactor;

        protected override void OnLoad(EventArgs e)
        {

            base.OnLoad(e);

            //on cart load, get discount rate if logged in, apply discount to cart total
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


            if (Session["StoneWoodCartId"] != null)
            {
                CartId = new Guid(Session["StoneWoodCartId"].ToString());
            }

            if (Page.Request.Cookies["StoneWoodCartId"] != null)
            {
                try
                {
                    CartId = new Guid(Request.Cookies["StoneWoodCartId"].Value.ToString());
                }
                catch (Exception) 
                { 

                }
            }

            Cart = daLayer.GetCart(CartId, 0);
            CartId = (Guid)Cart._Cart.Rows[0]["CartId"];

            HttpCookie cookie = new HttpCookie("StoneWoodCartId");
            cookie.Value = CartId.ToString();
            cookie.Expires = DateTime.Now.AddDays(1);
            Session["StoneWoodCartId"] = CartId;
            Response.Cookies.Add(cookie);

            this.ItemCount.Text = Cart._Cart.FindByCartId(CartId).ItemCount.ToString();
            this.OrderTotal.Text = ((decimal)priceFactor * Cart._Cart.FindByCartId(CartId).OrderSubTotal).ToString("C");

            this.CartViewLink.Attributes["onclick"] = "showCartDiv('" + CartId.ToString() + "')";
            //this.CartViewLink.Attributes["onclick"] = Response.Redirect("shoppingcart.aspx", false);
        }
    }
}