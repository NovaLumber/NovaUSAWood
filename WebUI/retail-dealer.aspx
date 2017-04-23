<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="retail-dealer.aspx.cs" Inherits="WebUI.retail_dealer" Title="Untitled Page" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server"><div id="mainWithSideBar">
<div id="directory-listing">

    <div style="width:360px; float:left;">

        <h1><%= MyDealer.company_name%> , <%= MyDealer.city %>, <%= MyDealer.state %> </h1>
        
        <p>Featuring: <%= MyDealer.products %> in <%= MyDealer.species %></p>
        
        <p><%= MyDealer.tagline %></p>

        <p><%= MyDealer.about %></p>
        
        <ul>
            <li style="padding-bottom:8px;">Location:</li>
            <li><%= MyDealer.company_name %></li>
            <li><%= MyDealer.address1 %> <%= MyDealer.address2 %></li>
            <li style="padding-bottom:8px;"><%= MyDealer.city %>, <%= MyDealer.state %> <%= MyDealer.zip %></li>
            <li>Phone: <a href="tel:<%= MyDealer.phone_format %>"><%= MyDealer.phone_format %></a></li>
            <li style="padding-bottom:8px;">Fax: <%= MyDealer.fax_format %></li>
            <li>email: <a href="mailto://<%= MyDealer.email_address %>?subject=Inquiry about products from Nova" ><%= MyDealer.email_address %></a></li>
            <li>web site: <a href="http://<%= MyDealer.website %>" target="_blank" ><%= MyDealer.website %></a></li>       
        </ul>

        <h2>Products: <%= MyDealer.products %> </h2>
        
        <h3>Species: <%= MyDealer.species %> </h3>

        <h3>Services: <%= MyDealer.services %> </h3>
        
    </div>
    
    <p style="float:right; padding:0px 0px 10px 0px;">
        <iframe width="360" height="550" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=<%= MyDealer.address1 %>+<%= MyDealer.address2 %>+<%= MyDealer.city %>+<%= MyDealer.state %>&amp;ie=UTF8&amp;hq=&amp;hnear=<%= MyDealer.address1 %>+<%= MyDealer.address2 %>+<%= MyDealer.city %>+<%= MyDealer.state %>&amp;z=16&amp;output=embed"></iframe><br /><small><a href="http://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=<%= MyDealer.address1 %>+<%= MyDealer.address2 %>+<%= MyDealer.city %>+<%= MyDealer.state %>&amp;ie=UTF8&amp;hq=&amp;hnear=<%= MyDealer.address1 %>+<%= MyDealer.address2 %>+<%= MyDealer.city %>+<%= MyDealer.state %>&amp;z=16&amp;" style="color:#fff;text-align:left">View Larger Map</a></small>    
    </p>
    
    <div style="clear:both;"></div>
    

</div>
<div class="clearfix"></div></div><!-- end mainWithSideBar --></asp:Content>  