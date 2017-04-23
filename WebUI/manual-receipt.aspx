<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="manual-receipt.aspx.cs" Inherits="WebUI.manual_receipt" Title="Manual Payment Receipt" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server"><div id="mainWithSideBar">

<div id="checkout-outer" style="padding-left:30px;">
    <div id="checkout">

            <h2>Manual Payment Completed</h2>
            
            <p><asp:Label ID="manualPmtLabel" runat="server"></asp:Label></p>
            
            <p><asp:Label ID="manualPmtAmount" runat="server"></asp:Label></p>
            
            <p>Payment Received From:<br />
            <asp:Label ID="buyerLabel1" runat="server"></asp:Label><br />
            <asp:Label ID="buyerLabel2" runat="server"></asp:Label><br />
            <asp:Label ID="buyerLabel3" runat="server"></asp:Label><br />
            <asp:Label ID="buyerLabel4" runat="server"></asp:Label><br />
            <asp:Label ID="buyerLabel5" runat="server"></asp:Label></p>
            
            <p>Thank you!</p>
            
    </div>
</div>

<div class="clearfix"></div></div><!-- end mainWithSideBar --></asp:Content>  