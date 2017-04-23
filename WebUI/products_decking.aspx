<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="products_decking.aspx.cs" Inherits="WebUI.products_decking" Title="Untitled Page" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:DeckingNavigation id="DeckingNavigation1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server"><div id="mainWithSideBar">
<div class="bodyText_noBanner">

    <h2>Decking Products</h2>
    <ul class="linkList">
        <li class="imageList">
            <img alt="" src="images\products\Deck\AngelimPedra\deck_chair_450.jpg" />        
            <img alt="" src="images\products\Deck\TW\deck_03.jpg" />        
            <img alt="" src="images\products\Deck\Ipe\deck_01.jpg" />        
        </li>
    </ul>
    <div class="prodTypeCopy">Nova’s hardwood decking line includes the very best decking products available on the planet. Sustainably harvested, exotically beautiful and incomparably durable, the Nova decking line has a real wood product to serve every need.  </div>
     <a href="products.aspx?FilterstoAdd=451"><img alt="" src="images\ViewPds.png" class="viewButton" /></a>
</div>
<div class="clearfix"></div></div><!-- end mainWithSideBar --></asp:Content>  
