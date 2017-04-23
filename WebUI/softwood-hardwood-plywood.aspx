<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="softwood-hardwood-plywood.aspx.cs" Inherits="WebUI.softwood_hardwood_plywood" Title="Nova USA Wood Products - Plywood and Panel Product Line" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server"><div id="mainWithSideBar">

    <img alt="Plywood Panels" src="../images/products/plywood/red-oak/red-oak-top.jpg" width="740" height="375" />
    
    <div class="leftColumn">
        <h1>Imported Plywood and Panels - Softwood Plywood - Hardwood Plywood</h1>
        <h2>Imported Plywood Programs</h2>
        <img alt="Nova Products" src="../images/products/plywood/packing/nova-box.jpg" width="200" height="200" class="align-left" style="padding-right: 12px" />
        <p>We specialize in imported plywood, specifically designed for secondary manufacturing and distribution. We have quality control and logistics personnel at the production source. Our partnerships allow us to provide the highest level of quality and customization, while providing the most competitive pricing.</p>
        <h3>Imported Hardwood Plywood and Panels</h3>
        <p>Our hardwood plywood products come in a variety of species and sizes. We are able to offer specific varieties of tropical hardwoods which are often mixed into generic hardwood catagories. Due to the distinct grain and color characteristics of each species, we can tailor the selected specie to our customers' specific applications.</p>
        <p>Available sizes consist of 4x8 sheets with thicknesses of 2.7mm, 3.6mm, 4.0mm, 5.2mm, 5.5mm, 6.0mm, 12mm, 15mm, 18mm, 21.4mm and 25mm. Grades conform to standard IWPA  and HPVA hardwood plywood rules.</p>
    </div> <!-- end leftColumn -->
    
	<div class="rightColumn">
	    <a href="woodtypes.aspx" class="button">View Wood Types</a>
        <h3>Available Hardwood Species, click for picture</h3>
        <ul class="bullets">
            <li><a href="gallery-single.aspx?photo=plywood/bintangor/bintangor.jpg">Bintangor</a></li>
            <li><a href="gallery-single.aspx?photo=plywood/red-oak/red-oak.jpg">Red Oak</a></li>
            <li><a href="gallery-single.aspx?photo=plywood/poplar/poplar.jpg">Poplar</a></li>
            <li><a href="gallery-single.aspx?photo=plywood/red-birch/red-birch.jpg">Red Birch</a></li>
            <li><a href="gallery-single.aspx?photo=plywood/bcx_softwood/bcx_pine_face2.jpg">Pine</a></li>
        </ul>
        <h3>Imported Softwood Plywood and Panels - Specializing in ACX, BCX, CDX, CC/PTS Pine</h3>
        <img alt="Nova Products" src="../images/products/plywood/bcx/bcx_whouse_med.jpg" width="200" height="200" class="align-left" style="padding-right: 12px" />
        <p>We supply the full range of grades including: ACX, BCX, CC/PTS, and CDX. Sizes range from 1/4" to 1" in all standard thicknesses, in 4x8 panel sizes. Custom pricing and random length pricing programs are available.</p>
        <p>Our international logistics department specializes in door to door shipments by 20', 40' and 40' high cube containers. We negotiate volume shipping rates with customer service focused companies.</p>
        
        <h3>Contact Information</h3>
        <p>Please contact Bill Christou or Steve Getsiv at our <a href="contact.aspx" >corporate office</a> for more information. </p> 
        
    </div> <!-- rightColumn -->
    
<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->
</asp:Content>  