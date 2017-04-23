<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="elemental-world.aspx.cs" Inherits="WebUI.elemental_world" Title="Untitled Page" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:FlooringNavigation id="FlooringNavigation1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
<div id="mainWithSideBar" class="elemental">
    <img alt="elemental world" src="images/photo-elemental-world-top.jpg" />
    <div class="align-left">
        <h1>Elemental World Collection</h1>
        <h2>Gorgeous hardwood flooring from around the world</h2>
        <h3>Prefinished Hardwood Flooring</h3>
        <p>No other product has been able to replace solid hardwood flooring as the most durable and beautiful floor available. Our solid prefinished flooring features an aluminum oxide eight coat process to ensure a durable, high quality factory finish. Solid prefinished flooring can be sanded and refinished many times, offering a floor which will last a lifetime. Our flooring is precision milled with the highest quality equipment available. Our full time quality control and technical staff ensure the highest standards of fit and finish.<br />
        <a href="contact.aspx" class="button-new" title="Contact Us">Contact Us</a>
        <a href="tel:503-419-6407" class="button-new" title="Call Us">Call Us</a>
        </p>
        
        <h3>Other Elemental Collections</h3>
        <p>
        <!--<a href="elemental-classics.aspx">Elemental Classics</a><br />-->
        <a href="elemental-heritage.aspx">Elemental Heritage</a><br />
        <a href="elemental-exotics.aspx">Elemental Exotic</a><br />
        <a href="elemental-advantage.aspx">Elemental Advantage</a><br />
        <a href="prefinished-flooring.aspx">Elemental Overview</a></p>
        
        <h3>Environmental Responsibility</h3>
        <p>All products in the Elemental Flooring line are produced with the utmost care for our environment. From the tropical forests of South America and Southeast Asia to the deciduous forests of northern temperate regions, we engage in only selective and highly sustainable harvesting practices to ensure the continued health and prosperity of the forests we all rely on. The wood industry plays an important role in the preservation of the world’s forests by providing value and jobs in forest regions. By providing an economically viable alternative to clear cutting land for agricultural use, the wood industry ensures the continued preservation of the world’s standing forests.</p>
    </div> <!-- end align-left -->
    <div class="align-right">
        <a href="products.aspx?FilterstoAdd=456" class="button-new">View ELEMENTAL World Collection</a>
        <img alt="elemental world" src="images/photo-elemental-world-side.jpg" />
    </div> <!-- end align-right -->    
    <div class="clearfix"></div>
</div><!-- end mainWithSideBar -->
</asp:Content>