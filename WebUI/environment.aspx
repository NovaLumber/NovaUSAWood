<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="environment.aspx.cs" Inherits="WebUI.environment" Title="Untitled Page" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
<div id="mainWithSideBar">
<h1>Our Green Commitment</h1>
    <!-- <img alt="Our Commitment to the Environment" src="images/products/SiteImages/envirobanner.jpg" width="740" height="375" /> -->

    <div class="leftColumn">

        <img alt="Tropical Logging" src="./theme/one-sapling-200.jpg"  />
        <p>Logging practices in the tropical rainforest are generally misunderstood. Our goal is to help explain some of the issues regarding rainforest logging and to help consumers make intelligent decisions regarding lumber products from tropical South America. </p>
        <p>Tropical logging is NOT clear cutting. The Amazon forest is the most heterogeneous tropical forest in the world; selective harvesting of commercially viable species is the only economically viable approach to logging in this context. Clear-cutting occurs when land is cleared for farming and ranching. For timber extraction, selective harvesting of between 20 and 200 trees per 1000 acres is typical throughout the Amazon region.</p>

        <img alt="Tropical Logging" src="./theme/burned-200.jpg"  />
        <p>The greatest danger to our rainforests is the expansion of agricultural areas to grow food crops and raise cattle. In order for farmers to cultivate the land for crops or cattle, clear cutting must be done. Government agencies such as IBAMA in Brazil and third party certification agencies such as the FSC, Forest Stewardship Council, require land management plans which are based on selective and sustainable logging practices.</p>

        <img alt="Tropical Logging" src="./theme/fly-over-logging-area-200.jpg"  />
        <p>Landowners and local people need a way to get value from their land. With reasonable market prices and consumer support for tropical lumber products, the incentive to convert tropical forest to agricultural use is minimized. It is a way of adding value to the standing forest.</p>


    </div> <!-- end leftColumn -->
    
	<div class="rightColumn">
	
        <img alt="Tropical Logging" src="./theme/management-plan2-200.jpg"  />
	    <p>Companies logging in the rainforest must submit detailed forest management plans in order to extract timber. Each area to be logged is divided up into sections and trees are identified by specie. With the assistance of GPS, detailed maps can be created on computers and by hand. Seed trees of each specie are left so that natural regeneration may take place. Trees that are under certain sizes are also left in place so that they may be cut in the next logging cycle in 20 to 30 years.</p>

        <img alt="Tropical Logging" src="./theme/plantation-200.jpg"  />
        <p>In many cases, government agencies will require that companies also replant areas that have been cleared in the past. This is typically done with Teak or Mahogany plantations that can replace ranching areas. It doesn’t take long to turn a bare patch of land into a plantation forest; after only 5 years, the average height of these plantation trees is already 15 feet. Selective logging in the Amazon is THE best way to add value to the STANDING forest resource. People live in the Amazon and will use the forest resource for their livelihood. The Amazonian wood industry is well positioned to play a key role in helping to preserve the Amazon forests by providing value and jobs without chopping the forest down. </p>

    </div> <!-- rightColumn -->

<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->
</asp:Content>  
