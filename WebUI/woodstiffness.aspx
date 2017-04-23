<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="woodstiffness.aspx.cs" Inherits="WebUI.woodstiffness" Title="Nova - Wood Stiffness" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
<div id="mainWithSideBar">
    <div id="stiffness-page">
    <h1>Modulus of Elasticity (MOE) Ratings for Various Species of Wood (1000 psi)</h1>
    <p>Modulus of elasticity ratings are derived from the stiffness or resistence to bending of the particular wood species. These ratings pertain to longitudinal modulus of elasticity, not tangential or radial ratings.<sup>(1)</sup></p>
        <ul>
            <asp:Repeater ID="SpecieRepeater" runat="server">
                <ItemTemplate>
                    <li>
                    <div style="width:<%#(((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).moe/5.5+100).ToString("N0") %>px;" class="chartBar">
                        <a href="products.aspx?FilterstoAdd=<%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).FilterEntry_id.ToString("N0")%>" class="chartLink" >
                        <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).species_description.ToString() %>
                        <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).moe.ToString("N0") %> <span style="font-size:0.9em;"> 1000 psi</span>
                        </a>
                    </div>
                    </li>
                </ItemTemplate>                    
            </asp:Repeater>
                
        </ul>
            
    <p><sup>(1)</sup> The Wood Handbook - Wood as an engineering material, USDA, General Technical Report 113.</p>
    </div> <!-- end stiffness-page -->
<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->
</asp:Content>  