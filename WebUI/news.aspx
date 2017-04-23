<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="news.aspx.cs" Inherits="WebUI.news" Title="Untitled Page" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
<div id="mainWithSideBar">
    <div id="oldPage">
        <h1>Links and News</h1>  
        <h2>Articles and Links</h2>

            <h3><a target="_blank" href="http://www.findanyfloor.com">FindAnyFloor.com - The Best Flooring Resource Site on the Web</a></h3>
            <p>FindAnyFloor.com provides comprehensive information about hardwood
            flooring, carpets, laminate and tile. Complete with videos, buying guides, forums, installation 
            information, and more. This is a great place to start learning about flooring options.</p>

            <h3><a href="PDFs/2006MerryIJSD.pdf" target="_blank">Frank Merry, Int. J. Sustainable Development, Vol. 9, No. 3, 2006  
            Industrial Development on Logging Frontiers in the Brazilian Amazon</a></h3>
            <p>How can the Amazonian logging industry transition into environmentally and economically sustainable practices? 
            Merry's article explores this issue in depth. </p>
            
            <h3><a href="PDFs/Keller_et_al_Frontiers_in_Ecology_2007.pdf" target="_blank">Michael Keller et al, Frontiers 2007, Timber Production in Selectively Logged Tropical Forests in South America</a></h3>
            <p>Recommendations for how industry, government, and the scientific community can work together in order to preserve tropical forests in South America.</p>
            
            <h3><a href="http://www.nytimes.com/2008/05/25/world/americas/25amazon.html?ex=1212292800&ampen=b6e6bdfbdd2cb62b&ampei=5070&ampemc=eta1Alexei" target="_blank"> New York Times: "Brazil Rainforest Analysis Sets Off Political Debate" By Alexei Barrionuevo </a></h3>
            <p>Photographs taken by satellites of tropical forests in Brazil cause debates about just how much deforestation is actually occuring in the regions due to selective harvesting.</p>
            
            <h3><a href="PDFs/TimberCrisisPara.pdf" target="_blank">Aimex, The Timber Sector Crisis Scenario in Para State</a></h3>
            <p>The timber industry in the Brazilian state of Para faces challenges keeping its industry intact and thriving while also protecting and preserving its forests.</p>
            
            <h3><a href="fediukdeck_article.aspx" target="_blank">Northscaping.com: "All Decked Out And Still Can't Decide" by Stefan Feduik</a></h3>
            <p>Stefan Feduik considers the question of what makes a great decking material, focusing on Angelim Pedra.</p>
            
            <h3><a href="getsivdeck_article.aspx" target="blank">Building-Materials.com: "Decking it Out"</a></h3>
            <p>What are the pros and cons of 4" wide decking versus 6"? This article explores different perspectives on the topic. </p>
            
        </dl>
     
    </div> <!-- end oldPage -->
<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->
</asp:Content>  