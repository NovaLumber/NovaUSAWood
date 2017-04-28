<%@ Page Title="" Language="C#"  MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="photo-gallery-next.aspx.cs" Inherits="WebUI.photo_gallery_next" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Header" runat="server">
    <link rel="canonical" href="http://www.novausawood.com" />

    <title>Hardwood Flooring & Decking Images, Photos of Interior Flooring & Tropical Hardwood Exterior Decking</title>
    <meta name="Description" content="Images of Hardwood Flooring and Exterior Decking - Tropical Hardwood, Imported Hardwood Flooring & Decking Photos" />
    <meta name="Keywords" content="Images, Photos, Flooring, Decking, Interior Hardwood Flooring, Exterior Hardwood Decking" />    
</asp:Content>
<%--Link to the CSS file that enables the lightbox.--%>
<asp:Content ID="Scripts" ContentPlaceHolderID="LocalScripts" runat="server">
    <link href="Theme/lightbox.min.css" rel="Stylesheet" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Content" runat="server">
    <div id="mainNoSideBar">
            <div id="photogallery">
    
                <h1>Interior Hardwood Flooring Images, Photos of Exterior Hardwood Decking</h1> 
        
                <%= myFileListing %>

            </div>
    </div> 
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="FooterScripts" runat="server">
    <script type="text/javascript" src="scripts/lightbox-plus-jquery.min.js"></script>
</asp:Content>
