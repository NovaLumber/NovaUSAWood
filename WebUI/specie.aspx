<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="specie.aspx.cs" Inherits="WebUI.specie" Title="Specie Page" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    
    <div id="mainWithSideBar">
            
                <h1><%= mySpecie.title%></h1>

                <a href="products.aspx?FilterstoAdd=<%= mySpecie.FilterEntry_id.ToString("N0")%>">
                    <img class="species-image" alt="Click to view these <%= mySpecie.title%> products..." title="Click to view these <%= mySpecie.title%> products..." src="<%= mySpecie.photo_link.ToString() %>" />
                </a>
                
                <p class="species-paragraph">
                <%= mySpecie.species_description%> Hardwood Technical Information for
                Exotic Hardwood Flooring and Decking, Prefinished Solid Flooring, 
                Unfinished Solid Flooring and Engineered Flooring.</p>    
                    
                <ul class="species-ul">
                    <li style="padding-bottom:10px;"><em>Description:</em> <%= mySpecie.web_desc.ToString()%></li>
                    <li style="padding-bottom:10px;"><em>More Info:</em> <%= mySpecie.about.ToString()%></li>
                    <li style="padding-bottom:10px;"><em>Other Names:</em> <%= mySpecie.other_names.ToString()%></li>                                
                    <li style="padding-bottom:10px;"><a href="products.aspx?FilterstoAdd=<%= mySpecie.FilterEntry_id.ToString("N0")%>">View these products</a></li>
                </ul>
                
                <h2><%= mySpecie.species_description%> Hardwood Scientific Properties and Technical Specifications</h2>                                
                <ul class="stdul">
                    <li><a href="woodhardness.aspx"><em>Janka Hardness:</em></a> <%= mySpecie.hardness.ToString("N0")%> pounds</li>                                
                    <li><a href="woodstrength.aspx"><em>Strength (MOR):</em></a> <%= mySpecie.mor.ToString("N0")%> psi</li>                                
                    <li><a href="woodstiffness.aspx"><em>Stiffness (MOE):</em></a> <%= mySpecie.moe.ToString("N0")%> 1000 psi</li>                                
                    <li><a href="wooddensity.aspx"><em>Density (KG/m3):</em></a> <%= mySpecie.density.ToString("N0")%> </li>                                
                    <li><em>Color:</em> <%= mySpecie.color.ToString()%></li>
                    <li><em>Photosensitivity:</em> <%= mySpecie.photosensitive.ToString()%></li>
                    <li><em>Tangential Shrinkage:</em> <%= mySpecie.tang_shrink.ToString("P1")%></li>                                
                    <li><em>Radial Shrinkage:</em> <%= mySpecie.rad_shrink.ToString("P1")%></li>   
                    <li><em>Family:</em> <%= mySpecie.family.ToString()%></li>
                    <li><em>Tree Characteristics:</em> <%= mySpecie.tree.ToString()%></li>
                    <li><em>Geographic Area:</em> <%= mySpecie.distribution.ToString()%></li>
                    <li><em>Texture:</em> <%= mySpecie.texture.ToString()%></li>
                    <li><em>Grain:</em> <%= mySpecie.grain.ToString()%></li>
                    <li><em>Luster:</em> <%= mySpecie.luster.ToString()%></li>
                    <li><em>Durability Rating:</em> <%= mySpecie.durability.ToString()%></li>  
                    <li><em>Drying Characteristics:</em> <%= mySpecie.drying.ToString()%></li>  
                    <li><em>Working Characteristics:</em> <%= mySpecie.working.ToString()%></li>  
                    <li><em>Applications:</em> <%= mySpecie.applications.ToString()%></li>  
                    <li></li>
                    <li><a href="products.aspx?FilterstoAdd=<%= mySpecie.FilterEntry_id.ToString("N0")%>">
                    <strong>View these products...</strong>
                    </a></li>                            
                </ul>            

                <h3>Other Species of Wood from Nova USA</h3>
                    <div id="repeater">
                    <asp:Repeater ID="SpecieRepeater" runat="server">
                        <ItemTemplate>
                            <a href="<%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).url.ToString() %>"> <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).species_description.ToString() %> </a>
                             | 
                        </ItemTemplate>                    
                    </asp:Repeater>
                    </div>
                
                      
<div class="clearfix"></div></div><!-- end mainWithSideBar --></asp:Content>  