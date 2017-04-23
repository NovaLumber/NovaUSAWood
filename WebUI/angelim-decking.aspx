<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="angelim-decking.aspx.cs" Inherits="WebUI.angelim_decking" Title="Untitled Page" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:DeckingNavigation id="DeckingNavigation1" runat="server" /> 
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server"><div id="mainWithSideBar">

    <img alt="Angelim Pedra Hardwood Decking" src="./theme/angelim-740x375.jpg" width="740" height="375" />

	<div class="leftColumn">
        <h1>Angelim Pedra Decking<br />Angelim Hardwood Decks</h1>
        <h2>The distinctly unique look of Angelim Pedra hardwood decking.</h2>
        <img alt="Angelim Pedra Deck" src="images/products/Deck/AngelimPedra/AngelimSpoolMed.jpg" width="200" height="200" class="align-left" style="padding-right: 12px" />
        <p><em>Angelim Pedra</em> is an attractive beige-brown with reddish undertones punctuated by its characteristic <em>mineral spots</em> ("pedra" or "rock" in Portuguese). </p>
        <p> If left untreated, <em>Angelim Pedra Decking</em> will gradually age to a lustrous silver-grey. It can be <em>oiled</em> or <em>stained</em> to retain its rich tan-brown color. 
        This <em>decking</em> is available in 5/4 x 6.</p>
    </div> <!-- end leftColumn -->
        	
	<div class="rightColumn">
	    <a href="products.aspx?FilterstoAdd=451" class="button-new" style="margin-left: 10px;">View NOVA Hardwood Decking Products</a>
        <h3>Envioronmental friendliness, stability, and easy staining make Angelim Pedra decking a well-rounded choice.</h3>
        <img alt="Angelim Pedra Hardwood" src="images/products/Deck/AngelimPedra/AngelimSwMed.jpg" width="200" height="200" class="align-left" style="padding-right: 12px" />
        <p><em>Angelim Pedra Decking</em> is a medium-high density <em>hardwood</em> which is kiln dried for <em>maximum stability</em>. It also easily absorbs <em>stains</em> and <em>oils</em>. <em>Angelim Pedra Decking</em> is very durable and resistant to both fungi and termites. Our <em>Angelim Pedra</em> contains no harmful chemicals and can be used near water with no worry of contamination.</p>
        <h3>Natural wood decking made economical.</h3>
        <p>An <em>Angelim Pedra deck</em> is an economical natural alternative to other <em>decking</em> options when the entire life cycle of the deck or outdoor project is considered. Its rich color and natural grain is breathtaking and is certain to provide a lifetime of beauty.</p>

        <!--   
            <div class="logos">
                <img alt="Angelim Pedra Shipping Box" src="images\products\Deck\Ipe\IpeShippingBoxSmall.jpg" />
                <img alt="Warranty" src="images\25yeartrans.png" />  
                <img alt="Quality Control Test" src="images\products\Deck\Ipe\Gauge.jpg" />
                <a href="environment.aspx"><img alt="Nova Green" src="images\novagreen3.png" /></a>
            </div>
        --> 

    </div> <!-- rightColumn -->   

    <div class="clearfix"></div>
    </div><!-- end mainWithSideBar -->
</asp:Content>  