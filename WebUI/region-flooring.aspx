<%@ Page Title="" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="region-flooring.aspx.cs" Inherits="WebUI.region_flooring" %>
<asp:Content ID="Master" ContentPlaceHolderID="Header" runat="server">
    <title><%= myRegion.region_name %> Hardwood Flooring, Batu | Ipe | Cumaru, Direct Shipment</title>
    <meta name="Description" content="Your source in <%= myRegion.region_name %> for Hardwood Flooring in Batu, Ipe & Cumaru. Direct shipment to <%= myRegion.region_name %>." />
    <meta name="Keywords" content="<%= myRegion.region_name %>, <%= myRegion.region_abbrev %>, Batu, Ipe, Cumaru, Wholesaler, Hardwood Flooring, Hardwood, Siding, Ceiling, Paneling, Boards, Lumber, Direct, Shipment" />
</asp:Content>

<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:FlooringNavigation id="FlooringNavigation1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server"><div id="mainWithSideBar">
    
    <img alt="Batu Flooring Modern Design" title="Batu Flooring Modern Design" src="../theme/batu-close-up-740x375.jpg"  />

    <div class="leftColumn">
            <h1><%= myRegion.region_name %>'s Best Source for Hardwood Flooring | Batu, Ipe & Cumaru</h1>

            <p>We can supply and ship to <%= myRegion.region_name %> from our <%= myRegion.region_closest_warehouse %> warehouse.
            Our premium hardwood flooring products such as Batu Flooring, Ipe Flooring and Cumaru Flooring are available for direct shipment to
            <%= myRegion.region_name %> from <%= myRegion.region_closest_warehouse %>.
            </p>

            <h2>Shipping to <%= myRegion.region_name %>?</h2>

            <p>Just give us a call to find out how we can ship our hardwood flooring products to <%= myRegion.region_desc %> from our warehouse. 
            Nova has an extensive network of wholesale distributors and lumber yard retailers throughout the US and Canada. 
            Our hardwood flooring distributors generally stock many of our wood deck products including Batu 1x4, Batu 1x6, Batu 5/4x4 and Batu 5/4x6; 
            Ipe 1x4, Ipe 1x6, Ipe 5/4x4 and Ipe 5/4x6; and Cumaru 1x4, Cumaru 1x6 and Cumaru 5/4x6.  
            </p>

            <h2>Batu, Ipe & Cumaru Hardwood Flooring Accessories & Patterns</h2>
            
            <p>We stock at extensive amount of accessory items and can run a wide variety of custom patterns for just about any flooring project you
            can imagine. We get a lot questions from homeowners, designers and architects about how best to use our beautiful hardwood products. Please don't
            hesitate to give us a call. We will always do our best to answer your detailed questions about installation, availability and appropriate use of our products
            in flooring, siding, ceiling, paneling and other interior or exterior projects.
            </p>

            <p>We pride ourselves in terms of excellent customer service - we'll always get back to you as promptly as possible. 
            If you get our voicemail don't hesitate to leave a message - voicemails are routed to our salespeople by email immediately, day or night.
            </p>

            <p>Thank you for giving us the opportunity to serve you.<br />Yes! We CAN ship to <%= myRegion.region_name %>!</p>

            <a href="contact.aspx" class="button-new" title="Contact Us">Contact Us</a>
            <a href="tel:503-419-6407" class="button-new" title="Call Us">Call Us</a>

        </div>

    <div class="rightColumn">
        <a href="products.aspx?FilterstoAdd=449" class="button-new" title="View Hardwood Flooring Products" alt="View Nova Hardwood Flooring Products" style="margin-left: 10px;">View Hardwood Flooring Products</a>

            <h2>Easy Shipping to <%= myRegion.region_abbrev %> - <%= myRegion.region_name %></h2>

            <p><%= myRegion.region_map %></p>

            <p>We can ship to the following locations:</p>

            <div id="repeater">
            <asp:Repeater ID="RegionRepeater" runat="server">
                <ItemTemplate>
                    <a href="<%#((BusinessTier.DataAccessLayer.RegionWebFlooring.region_web_flooringRow)Container.DataItem).url.ToString() %>"> <%#((BusinessTier.DataAccessLayer.RegionWebFlooring.region_web_flooringRow)Container.DataItem).region_desc.ToString() %> </a>
                    &nbsp;  &nbsp
                </ItemTemplate>                    
            </asp:Repeater>
            </div>

            <p style="float:left; padding:10px 0px 10px 0px;">
                <iframe width="369" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=<%= myRegion.region_map %>&amp;z=<%= myRegion.zoom %>&amp;output=embed"></iframe><br /><small><a href="http://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=<%= myRegion.region_map %>&amp;ie=UTF8&amp;hq=&amp;hnear=<%= myRegion.region_map %>&amp;z=<%= myRegion.zoom %>&amp;" style="color:#fff;text-align:left">View Larger Map</a></small>    
            </p>
        </div>

    <div class="clearfix"></div>
    </div>
</asp:Content>
