<%@ Control Language="C#" AutoEventWireup="True" CodeBehind ="ShoppingCartPlugin.ascx.cs" Inherits="WebUI.Controls.ShoppingCartPlugin" %>

            <a href="" onclick="alert('This event handler should be reset by the server');" class="CartViewLink" id="CartViewLink" runat="server">View Cart</a>

            <!--<a href="/ShoppingCart.aspx" class="CartViewLink" id="CartViewLinkNew" runat="server">View Cart</a>-->

            <a href="/Checkout.aspx" class="CartCheckout">Check Out</a>
            <p><asp:Label ID="ItemCount" runat="server"/> Items in your Cart</p>
            <!--<p>Total is: <asp:Label ID="OrderTotal" runat="server"/></p>-->
