<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="WoodTypes.aspx.cs" Inherits="WebUI.WoodTypes" Title="Nova - Types of Wood We Offer" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">

<div id="mainWithSideBar">
<h1>Our Wood Types</h1>

    <a href="#A" >A</a>
    <a href="#B" >B</a>
    <a href="#C" >C</a>
    <a href="#D" >D</a>
    <a href="#E" >E</a>
    <a href="#F" >F</a>
    <a href="#G" >G</a>
    <a href="#H" >H</a>
    <a href="#I" >I</a>
    <a href="#J" >J</a>
    <a href="#K" >K</a>
    <a href="#L" >L</a>
    <a href="#M" >M</a>
    <a href="#N" >N</a>
    <a href="#O" >O</a>
    <a href="#P" >P</a>
    <a href="#Q" >Q</a>
    <a href="#R" >R</a>
    <a href="#S" >S</a>
    <a href="#T" >T</a>
    <a href="#U" >U</a>
    <a href="#V" >V</a>
    <a href="#W" >W</a>
    <a href="#X" >X</a>
    <a href="#Y" >Y</a>
    <a href="#Z" >Z</a>
    
    <div id="woodTypesList">
    <asp:Repeater ID="SpecieRepeater" runat="server">
    <ItemTemplate>
        <h1 id="<%#this.FirstLetter(((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).species_description.ToString())%>"><%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).species_description.ToString()%></h1>
        <div class="woodTypeImage"><a href="products.aspx?FilterstoAdd=<%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).FilterEntry_id.ToString("N0")%>">
        <img alt="hardwood flooring" src="<%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).photo_link.ToString() %>"/></a>
        </div> <!-- end woodTypeImage -->
        <div class="woodTypeDescription">
            <ul>               
                <li><strong>Other Names:</strong> <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).other_names.ToString() %></li>
                <li><strong>Description:</strong> <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).web_desc.ToString()%></li>
                <li><strong>Janka Hardness:</strong> <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).hardness.ToString("N0")%> pounds</li>
                <li><strong>Strength (MOR):</strong> <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).mor.ToString("N0")%> psi</li>
                <li><strong>Stiffness (MOE):</strong> <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).moe.ToString("N0")%> 1000 psi</li>                                
                <li><strong>Density (KG/m3):</strong> <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).density.ToString("N0")%></li>                                
                <li><strong>Tangential Shrinkage:</strong> <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).tang_shrink.ToString("P1")%></li>                                
                <li><strong>Radial Shrinkage:</strong> <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).rad_shrink.ToString("P1")%></li>                                
            </ul>
         </div>
     </ItemTemplate>
     </asp:Repeater>
     </div> <!-- end woodTypesList -->
<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->

</asp:Content>  
