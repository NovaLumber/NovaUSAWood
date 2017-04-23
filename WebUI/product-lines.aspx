<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="product-lines.aspx.cs" Inherits="WebUI.product_lines" Title="Untitled Page" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server"><div id="mainWithSideBar">
<div class="bodyText_noBanner">

    <h2>Product Lines</h2>
    
    <div class="multi_column">
        <div class="featured_title"><h3><a href="unfinished-flooring.aspx">Unfinished Flooring</a></h3></div>
        <ul class="linkList">
            <li>Solid Exotic Hardwood Flooring</li>
            <li>3/4" x 2-1/4", 3", 4" and 5"</li>
            <li>Standard lengths are 1-7'</li>
            <li>Brazil, Peru, Bolivia, Paraguay</li>
        </ul>
    </div>
    
    <div class="multi_column">
        <div class="featured_title"><h3><a href="prefinished-flooring.aspx">Prefinished Flooring</a></h3></div>
        <ul class="linkList">
            <li>Solid Exotic Hardwood Flooring</li>
            <li>Factory Finished with 8 Coats of Aluminum Oxide</li>
            <li>3/4" x 2-1/4", 3", 4" and 5"</li>
            <li>Standard lengths are 1-7'</li>
            <li>Brazil, Peru, Bolivia, Paraguay</li>
        </ul>
    </div>
    
    <div class="multi_column">
        <div class="featured_title"><h3><a href="fsc-engineered-flooring.aspx">FSC Engineered Flooring</a></h3></div>
        <ul class="linkList">
            <li>Engineered Exotic Hardwood Flooring</li>
            <li>3/8" x 3", 5" and 1/2" x 3", 5"</li>
            <li>Standard board lengths are 1-4'</li>
            <li>Brazil, Peru, Bolivia, Paraguay, United States</li>
            <li>Forest Stewardship Council Certified</li>
        </ul>
    </div>
    
    <div class="multi_column">
        <div class="featured_title"><h3><a href="angelim-decking.aspx">Angelim Exterior Decking</a></h3></div>
        <ul class="linkList">
            <li>Solid Hardwood Decking</li>
            <li>Naturally Durable</li>
            <li>25 Year Warranty</li>
            <li>R/L 8-20' Evens</li>
            <li>5/4x4 and 5/4x6 Available</li>
        </ul>
    </div>
     
    <div class="multi_column">
        <div class="featured_title"><h3><a href="ipe-decking.aspx">Ipe Exterior Decking</a></h3></div>
        <ul class="linkList">
            <li>Solid Hardwood Decking</li>
            <li>Naturally Durable</li>
            <li>25 Year Warranty</li>
            <li>R/L 8-20' Evens</li>
            <li>1x4 1x6 5/4x4 and 5/4x6</li>
        </ul>
    </div>
    
    <div class="multi_column">
        <div class="featured_title"><h3><a href="hardwood-decking.aspx">Exterior Decking</a></h3></div>
        <ul class="linkList">
            <li>Solid Exotic Exterior Decking</li>
            <li>5/4" x 4", 6" and 1" x 4", 6"</li>
            <li> 2" x 2", 4", 6", 8", 10", 12" </li>
            <li>Standard board lengths are 8'-20'</li>
            <li>Brazil, Peru, Bolivia, Paraguay</li>
       </ul>
    </div>
   
</div>
<div class="clearfix"></div></div><!-- end mainWithSideBar --></asp:Content>  
