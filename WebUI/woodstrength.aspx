<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="woodstrength.aspx.cs" Inherits="WebUI.woodstrength" Title="Nova - Wood Strength" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
<div id="mainWithSideBar">
    <div id="strength-page">
    <h1>Modulus of Rupture (MOR) Ratings for Various Species of Wood (psi)</h1>
    <p>The modulus of rupture is a measure of the maximum load carrying capacity of a given species in bending strength and is proportional to the breaking point or maximum strength as borne by the specimen.<sup>(1)</sup></p>
        <ul>
            <asp:Repeater ID="SpecieRepeater" runat="server">
                <ItemTemplate>
                    <li>
                    <div style="width:<%#(((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).mor/47+100).ToString("N0") %>px;" class="chartBar">
                        <a href="products.aspx?FilterstoAdd=<%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).FilterEntry_id.ToString("N0")%>" class="chartLink" >
                        <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).species_description.ToString() %>
                        <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).mor.ToString("N0") %> psi
                        </a>
                    </div>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
            
        </ul>

    <p><sup>(1)</sup> The Wood Handbook - Wood as an engineering material, USDA, General Technical Report 113.</p>
    </div> <!-- end strength-page -->
<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->
</asp:Content>