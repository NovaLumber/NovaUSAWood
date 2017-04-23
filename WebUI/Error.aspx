<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="error.aspx.cs" Inherits="WebUI.error" Title="Nova - Error Generated" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server"><div id="mainWithSideBar">

<div style="padding:30px 360px 50px 20px;">
<h1>Sorry, our web site has generated an error.</h1>

<h2>We have attempted to redirect you to the correct page but were unable to do so. Please choose an item from the menus above.</h2>

<h2>Thank you.</h2>
</div>
<div class="clearfix"></div></div><!-- end mainWithSideBar --></asp:Content>  