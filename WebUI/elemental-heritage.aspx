<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="elemental-heritage.aspx.cs" Inherits="WebUI.elemental_heritage" Title="Untitled Page" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:FlooringNavigation id="FlooringNavigation1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
<div id="mainWithSideBar" class="elemental">
    <img alt="elemental heritage" src="images/photo-elemental-heritage-top.jpg" />
    <div class="align-left">
        <h1>Elemental Heritage Collection</h1>
        <h2>Distinctive hand hewn hardwoods, the elegance of old world craftsmanship for your home</h2>
        <h3>Prefinished Hardwood Flooring</h3>
        <p>Featuring handscraped and distressed styles, our heritage collection offers the distinct looks of a naturally aged floor. Available in both engineered and solid formats, our heritage flooring is prefinished with an aluminum oxide eight coat process to ensure a durable, high quality factory finish. All of the products in our heritage collection offer a wear layer of at least 3mm which allows for sanding and refinishing, providing a floor which will last a lifetime. Full time quality control and technical staff ensure the highest standards of fit and finish. We recommend engineered products for all below grade applications.<br />
        <a href="contact.aspx" class="button-new" title="Contact Us">Contact Us</a>
        <a href="tel:503-419-6407" class="button-new" title="Call Us">Call Us</a>
        </p>

        <h3>Other Elemental Collections</h3>
        <p>
        <!--<a href="elemental-classics.aspx">Elemental Classics</a><br />-->
        <a href="elemental-exotics.aspx">Elemental Exotic</a><br />
        <a href="elemental-advantage.aspx">Elemental Advantage</a><br />
        <a href="prefinished-flooring.aspx">Elemental Overview</a></p>
        
        <h3>Environmental Responsibility</h3>
        <p>All products in the Elemental Flooring line are produced with the utmost care for our environment. From the tropical forests of South America and Southeast Asia to the deciduous forests of northern temperate regions, we engage in only selective and highly sustainable harvesting practices to ensure the continued health and prosperity of the forests we all rely on. The wood industry plays an important role in the preservation of the world’s forests by providing value and jobs in forest regions. By providing an economically viable alternative to clear cutting land for agricultural use, the wood industry ensures the continued preservation of the world’s standing forests.</p>
    </div> <!-- end align-left -->
    <div class="align-right">
        <a href="products.aspx?FilterstoAdd=485" class="button-new">View ELEMENTAL Heritage Collection</a>
        <img alt="elemental heritage" src="images/photo-elemental-heritage-side.jpg" />
    </div> <!-- end align-right -->    
<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->
</asp:Content>  
