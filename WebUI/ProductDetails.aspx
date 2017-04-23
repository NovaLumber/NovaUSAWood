<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/UiMasterPage.Master" CodeBehind="ProductDetails.aspx.cs" Inherits="WebUI.ProductDetails" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
<div id="mainNoSideBar">

<div id="product-page">

    <ul id="product-images">
        <li id="selected"><img name="PhotoBig" title="<%= MyProduct.speciesRow.species_description %> <%= MyProduct.gradeRow.grade_desc %> <%= MyProduct.usageRow.usage_desc %>" alt="<%= MyProduct.speciesRow.species_description %> <%= MyProduct.gradeRow.grade_desc %> <%= MyProduct.usageRow.usage_desc %>" src="<%=ProductPhotoRow.filename.ToString().Replace('\\','/') %>" /></li>
        <asp:Repeater ID="ProdPhotoRepeater" runat="server">
            <ItemTemplate>
                <li style="z-index:-1">
                    <a onmouseover="updateImage('<%#((BusinessTier.DataAccessLayer.ProductPhotos.prodphotosRow)Container.DataItem).filename.Replace('\\','/') %>', 0, false); return false;">
                    <img alt="<%= MyProduct.speciesRow.species_description %> <%= MyProduct.gradeRow.grade_desc %> <%= MyProduct.usageRow.usage_desc %>" title="<%= MyProduct.speciesRow.species_description %> <%= MyProduct.gradeRow.grade_desc %> <%= MyProduct.usageRow.usage_desc %>" src="<%#((BusinessTier.DataAccessLayer.ProductPhotos.prodphotosRow)Container.DataItem).filename.Replace('\\','/')%>" />
                    </a>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>

<div id="productDescription">
    <h1><%= MyProduct.long_desc %></h1>
    <h2><%= MyProduct.both_desc %></h2>
   
    <p><a href="where-to-buy-nova-flooring.aspx" class="button" id="buyButton" runat="server">Where To Buy</a><a href="products.aspx" style="margin-left:10px;" class="button">Back to Catalog</a></p>
        
    <div id="product-specs">
        <ul>
        <asp:Repeater ID="AttributeRepeater" runat="server">
            <ItemTemplate>
                <li><strong><%# ((BusinessTier.DataAccessLayer.Attributes.AttributeListingRow)((System.Data.DataRowView)Container.DataItem).Row).AttributeText%>: </strong>
                <%#this.GetAttributeValue(((BusinessTier.DataAccessLayer.Attributes.AttributeListingRow)((System.Data.DataRowView)Container.DataItem).Row).AttributeName) %></li>
            </ItemTemplate>
        </asp:Repeater>
        </ul>
        <div id="add"></div>
    </div> <!-- end product-specs -->

    <div style="clear:both;" id="related-specs">
        <p><strong>Specie Description</strong><br/><%= MyProduct.species_web_desc %></p>
        <p><strong>Grading</strong><br/><%= MyProduct.grade_web_desc %></p>
        <p><strong>General Product Information</strong><br/><%= MyProduct.class_web_desc %></p>
        <!--
        <p><strong>Quality is our Passion</strong><p><%= MyProduct.brand_web_desc %></p>
        -->
    </div> <!-- end related-specs -->
    
    <p><a href="products.aspx" class="button">Back to Catalog</a></p>
</div> <!-- end productDescription -->

</div> <!-- end product-page -->
<div class="clearfix"></div>
</div> <!-- end main without side bar -->
</asp:Content>  