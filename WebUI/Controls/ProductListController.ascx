<%@ Control Language="C#" AutoEventWireup="True" Codebehind="ProductListController.ascx.cs" Inherits="WebUI.Controls.ProductListController" %>

<div id="catalogPage">

<h1 id="catalogHeader" class="h1FloorFinder" runat="server">Floor Finder</h1>
    
<asp:Repeater ID="ProductDisplay" runat="server">
    <HeaderTemplate>
    <div id="product-list">
    </HeaderTemplate>
    
    <ItemTemplate>
    <div class="productItem">
        <h1><%#((BusinessTier.DataAccessLayer.ProductList.productsRow)Container.DataItem).long_desc%></h1>
        <div class="align-left">
        <a href="ProductID<%#((BusinessTier.DataAccessLayer.ProductList.productsRow)Container.DataItem).prod_id%>">
        <img src="<%#((BusinessTier.DataAccessLayer.ProductList.productsRow)Container.DataItem).image1filename.Replace('\\','/')%>" 
                title="<%#((BusinessTier.DataAccessLayer.ProductList.productsRow)Container.DataItem).long_desc%> <%#((BusinessTier.DataAccessLayer.ProductList.productsRow)Container.DataItem).usageRow.usage_desc%>" 
                alt="<%#((BusinessTier.DataAccessLayer.ProductList.productsRow)Container.DataItem).long_desc%> <%#((BusinessTier.DataAccessLayer.ProductList.productsRow)Container.DataItem).usageRow.usage_desc%>" />
        </a>
        </div> <!-- end align-left -->
    
        <div class="align-right">
        <%# this.showListPrice(((BusinessTier.DataAccessLayer.ProductList.productsRow)Container.DataItem).prod_id) %>
        <%# this.showYourPrice(((BusinessTier.DataAccessLayer.ProductList.productsRow)Container.DataItem).prod_id) %>
        <!-- <%# SetProdRow((BusinessTier.DataAccessLayer.ProductList.productsRow)Container.DataItem)%> -->
        <ul>
            <asp:Repeater ID="AttributeRepeater" runat="server" DataSource="<%# this.ProductAttributes %>" >
                <ItemTemplate>
                    <li><strong><%# ((BusinessTier.DataAccessLayer.Attributes.AttributeListingRow)((System.Data.DataRowView)Container.DataItem).Row).AttributeText%>:</strong> <%#this.GetAttributeValue(((BusinessTier.DataAccessLayer.Attributes.AttributeListingRow)((System.Data.DataRowView)Container.DataItem).Row).AttributeName)%></li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
        <p><%#((BusinessTier.DataAccessLayer.ProductList.productsRow)Container.DataItem).both_desc%></p>
        <a href="ProductID<%#((BusinessTier.DataAccessLayer.ProductList.productsRow)Container.DataItem).prod_id%>" class="button-small">View</a>
        </div> <!-- end align-right -->
        <div class="clearfix"></div>
    </div> <!-- end productItem -->
    </ItemTemplate>
    
    <FooterTemplate>
    </div> <!-- end product-list -->
    </FooterTemplate>
    
</asp:Repeater>

</div> <!-- end catalogPage -->