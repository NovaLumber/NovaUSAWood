<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="wooddensity.aspx.cs" Inherits="WebUI.wooddensity" Title="Nova - Wood Density" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
<div id="mainWithSideBar">
    <div id="stiffness-page">
        <h1>Density Ratings for Various Species of Wood (KG per Cubic Meter)</h1>
        <p>A wood product's weight is determined by combining the density of the basic wood structure with the material's moisture content. The density of wood, exclusive of water, varies a great deal within and between species. Density variations wthin a particular species of approximately 10% should be considered normal. A wood's weight is always partially contingent on its moisture content, so moisture should always be taken into consideration. The figures below represent the density at approximately 12% moisture content.<sup>(1)</sup></p>
        <ul>
            <asp:Repeater ID="SpecieRepeater" runat="server">
            <ItemTemplate>
            <li><div style="width:<%#(((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).density*.56+100).ToString("N0") %>px;" class="chartBar"><a href="products.aspx?FilterstoAdd=<%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).FilterEntry_id.ToString("N0")%>" class="chartLink" ><%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).species_description.ToString() %> <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).density.ToString("N0") %> KG/m3</a></div></li>
            </ItemTemplate>
            </asp:Repeater>
        </ul>
        <p><sup>(1)</sup> The Wood Handbook - Wood as an engineering material, USDA, General Technical Report 113.</p>
    </div> <!-- end stiffness-page -->
<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->
</asp:Content>  