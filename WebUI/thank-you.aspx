<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="thank-you.aspx.cs" Inherits="WebUI.thank_you" Title="Untitled Page" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server"><div id="mainWithSideBar">

<div style="min-height:300px; padding:20px 20px 20px 20px;">

    <h1 style="padding-bottom:20px;">Thank you for registering with Nova</h1>  
    
    <p>Thanks for registering with us. Your information has now been registered in our
    database. You should receive a confirming email as well.</p>
    
    <p>Be sure to let us know you've already created an account if you call or email us.</p>

    <p>If you are a retailer dealer or wholesale distributor and want to check on the status of your listing, just give us
    a call at 503.419.6407.</p>
        
</div>
    
<div class="clearfix"></div></div><!-- end mainWithSideBar --></asp:Content>  
