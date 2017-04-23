<%@ Page Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" Inherits="WebUI.Products" Codebehind="~/Products.aspx.cs" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar2" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
<div id="mainWithSideBar">

    <ui:FilterManager ID="FilterManager1" runat="server" />

    <ui:ProductListController ID="ProductListController1" runat="server" />

    <a href="contact.aspx" class="button-new" title="Contact Us">Contact Us</a>
    <a href="tel:503-419-6407" class="button-new" title="Call Us">Call Us</a>

    <div id="product-filter">
        <ui:ProductFilterCrumbs ID="ProductFilterCrumbs1" runat="server" />
        <ui:ProductMenu ID="ProductMenu1" runat="server" />
    </div> <!-- end product-filter -->

<div class="clearfix"></div>
</div> <!-- end mainWithSideBar -->
</asp:Content>