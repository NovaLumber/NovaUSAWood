<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="woodhardness.aspx.cs" Inherits="WebUI.woodhardness" Title="Nova - Wood Hardness" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
<div>
    <div id="hardness-page">
    <h1>Janka Hardness Ratings for Various Wood Species</h1>
    <p>The industry standard method for determining the hardness of wood products is called the Janka hardness test. 
        Janka hardness of a given wood species is defined by a resistance to indentation test as measured by the load 
        (pounds of pressure) required to embed a 
        11.28mm or 0.444" diameter ball to one-half its diameter into the wood. The Janka values presented are the 
        average of penetrations on both flat grain or plain sawn and vertical grain or quartersawn boards.
    </p>
    <ul>
    <asp:Repeater ID="SpecieRepeater" runat="server">
    <ItemTemplate>
        <li><div style="width:<%#(((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).hardness/6.3+90).ToString("N0") %>px;" class="chartBar" ><a href="products.aspx?FilterstoAdd=<%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).FilterEntry_id.ToString("N0")%>" class="chartLink" ><%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).marketing_name.ToString() %> <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).hardness.ToString("N0") %> lbs</a></div></li>
    </ItemTemplate>
    </asp:Repeater>
    </ul>
    <p>The Wood Handbook - Wood as an Engineering Material, USDA, General Technical Report 113.</p>
    </div> <!-- end hardness-page -->
<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->
</asp:Content>  