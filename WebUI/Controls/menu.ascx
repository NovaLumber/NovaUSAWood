<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="menu.ascx.cs" Inherits="WebUI.menu" %>
<ul id="nav">
	<li><a href="default.aspx" id="home">Home</a></li>
	<li><a href="product-lines.aspx">Product Lines</a>
		<ul style="z-index:999">
			<li><a href="unfinished-flooring.aspx">Unfinished Flooring</a></li>
			<li><a href="prefinished-flooring.aspx">Prefinished Flooring</a></li>
			<li><a href="fsc-engineered-flooring.aspx">FSC Engineered Flooring</a></li>
			<li><a href="elemental-hardwood-flooring.aspx">Elemental Flooring</a></li>
			<li><a href="hardwood-decking.aspx">Exterior Decking</a></li>
			<li><a href="softwood-hardwood-plywood.aspx">Plywood and Panels</a></li>
			<li><a href="trailer-decking.aspx">Trailer Decking</a></li>
			<li><a href="kiln-sticks.aspx">Kiln Drying Sticks</a></li>
		</ul>
	</li>
	<li><a href="products.aspx">Catalog</a>
		<ul style="z-index:999">
			<li><a href="products.aspx?FilterstoAdd=448">Unfinished Flooring</a></li>
			<li><a href="products.aspx?FilterstoAdd=449">Prefinished Flooring</a></li>
			<li><a href="products.aspx?FilterstoAdd=450">Engineered Flooring</a></li>
			<li><a href="products.aspx?FilterstoAdd=451">Exterior Decking</a></li>
			<li><a href="products.aspx?FilterstoAdd=452">Other Products</a></li>
		</ul>
	</li>
	<li><a href="woodtypes.aspx">Wood Types</a>
		<ul style="z-index:999">
			<li><a href="woodtypes.aspx">Types of Wood</a></li>
			<li><a href="woodhardness.aspx">Janka Hardness Chart</a></li>
			<li><a href="woodstrength.aspx">Strength Chart</a></li>
			<li><a href="woodstiffness.aspx">Stiffness Chart</a></li>
			<li><a href="wooddensity.aspx">Density Chart</a></li>
			<li><a href="ipe-decking-vs-cumaru-decking.aspx">Ipe vs. Cumaru Decking</a></li>
		</ul>
	</li>
	<li><a href="about.aspx">Information</a>
		<ul style="z-index:999">
			<li><a href="about.aspx">About Us</a></li>
    		<li><a href="gallery.aspx">Photo Gallery</a></li>
    		<li><a href="color-design-tool.aspx" target="_blank" >Color Design Tool</a></li>
    		<li><a href="deck-calculator.aspx">Deck Calculator</a></li>
    		<li><a href="downloads.aspx">Downloads</a></li>
    		<li><a href="warehouse-locations.aspx">Warehouse Locations</a></li>
    		<li><a href="nova-forest-brazil.aspx">Brazil Operations</a></li>
			<li><a href="environment.aspx">Environmental Concerns</a></li>
			<li><a href="news.aspx">Links and News</a></li>
			<li><a href="wood-floor-repair.aspx">Wood Floor Repair</a></li>
			<li><a href="wood-floor-installation.aspx">Solid Wood Floor Installation</a></li>
			<li><a href="engineered-floor-installation.aspx">Engineered Floor Installation</a></li>
		</ul>
	</li>
	<li><a href="contact.aspx">Contact Us</a>
		<ul style="z-index:999">
			<li><a href="contact.aspx">Contact Information</a></li>
			<!-- <li><a href="request.aspx">request product information</a></li> -->			
		</ul>
	</li>
</ul>
