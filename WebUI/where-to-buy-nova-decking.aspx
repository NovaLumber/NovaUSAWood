<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="where-to-buy-nova-decking.aspx.cs" Inherits="WebUI.where_to_buy_nova_decking" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server"><div id="mainNoSideBar">
<div id="directory-listing">
    <h1>Where to Buy Nova Decking Products</h1>
    <p>
        <!--City: <asp:TextBox runat="server" ID="city" Width="120px"></asp:TextBox> -->
        State: <asp:TextBox runat="server" ID="state" Width="40px"></asp:TextBox> 
        <!--Zip: <asp:TextBox runat="server" ID="zip" Width="80px"></asp:TextBox> -->
        <!--Wood Species: <asp:TextBox runat="server" ID="Species" Width="120px"></asp:TextBox> -->
        
        <asp:Button runat="server" ID="retrieve" OnClick="retrieve_Click" Text="Get Results" style="margin-top:10px; margin-left:26px;"/>
    </p>
    
    <table>
        <asp:Repeater ID="RecordRepeater" runat="server">
        <ItemTemplate><tr>
            <td><%#(((BusinessTier.DataAccessLayer.Registrations.registered_usersRow)Container.DataItem).company_name).ToString() %></td>
            <td style="padding-left:20px;"><%#(((BusinessTier.DataAccessLayer.Registrations.registered_usersRow)Container.DataItem).address1).ToString() %>
                <%#(((BusinessTier.DataAccessLayer.Registrations.registered_usersRow)Container.DataItem).address2).ToString() %></td>
            <td style="padding-left:20px;"><%#(((BusinessTier.DataAccessLayer.Registrations.registered_usersRow)Container.DataItem).city).ToString() %>,
                <%#(((BusinessTier.DataAccessLayer.Registrations.registered_usersRow)Container.DataItem).state).ToString() %>
                <%#(((BusinessTier.DataAccessLayer.Registrations.registered_usersRow)Container.DataItem).zip).ToString() %></td>
            <td style="padding-left:20px;"><a href="tel:<%#(((BusinessTier.DataAccessLayer.Registrations.registered_usersRow)Container.DataItem).phone_format).ToString() %>"><%#(((BusinessTier.DataAccessLayer.Registrations.registered_usersRow)Container.DataItem).phone_format).ToString() %></a></td>
            <td style="padding-left:20px;"><a href="retail-dealer.aspx?ID=<%#(((BusinessTier.DataAccessLayer.Registrations.registered_usersRow)Container.DataItem).user_id).ToString() %>" >more info...</a></td>
        </tr></ItemTemplate>                    
        </asp:Repeater>
    </table>            

    <p></p>
    <h2>Can't find a dealer or distributor in your area?</h2>
    <p>For Decking in the Eastern U.S. and Canada, please call Bill Christou at 416-483-0351.<br />
    For Western U.S. Decking, please call Steve Getsiv at 503-473-2878.</p>       
    
    <p>We take great pride in the quality of our products and we are always happy to answer any questions you may have. <a href="contact.aspx">Get in touch with us.</a></p>

    <a href="contact.aspx" class="button-new" title="Contact Us">Contact Us</a>
    <a href="tel:503-419-6407" class="button-new" title="Call Us">Call Us</a>
            
</div>
<div class="clearfix"></div></div><!-- end mainWithSideBar --></asp:Content>  