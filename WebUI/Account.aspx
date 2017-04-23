<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="WebUI.Account" Title="The Fantastic Floor - Account Maintenance" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server"><div id="mainWithSideBar">

<div></div>

    <h1>Account Summary Maintenance Window </h1>

<div id="login">

    <asp:ValidationSummary ID="editUserValidationSummary" runat="server" ValidationGroup="EditAccountValidationGroup" CssClass="ErrorMessages" DisplayMode=BulletList/>
        
    <ul>
        <li><em>Company Name:</em><asp:TextBox ID="CompanyName" runat="server"></asp:TextBox></li>
        
        <li><em>First Name:</em><asp:TextBox ID="FirstName" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ValidationGroup="EditAccountValidationGroup" enableclientscript="true" Display="Static" ID="FirstRequired" 
        ErrorMessage="First Name is a required field" ControlToValidate="FirstName" runat="server">*</asp:RequiredFieldValidator>
        </li>
        
        <li><em>Last Name:</em><asp:TextBox ID="LastName" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ValidationGroup="EditAccountValidationGroup" enableclientscript="true" Display="Static" ID="LastRequired" 
        ErrorMessage="Last Name is a required field" ControlToValidate="LastName" runat="server">*</asp:RequiredFieldValidator>
        </li>
        
        <li><em>Email Address:</em><asp:TextBox ID="EmailAddress" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ValidationGroup="EditAccountValidationGroup" enableclientscript="true" Display="Dynamic" ID="EmailRequired" 
        ErrorMessage="Email Address is a required field" ControlToValidate="EmailAddress" runat="server">*</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ValidationGroup="EditAccountValidationGroup" enableclientscript="true" 
        Display="Dynamic" ID="EmailRegex" ErrorMessage="Email Address is invalid" ControlToValidate="EmailAddress" 
        runat="server" ValidationExpression="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$">*</asp:RegularExpressionValidator>
        </li>
    </ul>    
    
    <p>
        <asp:CheckBox ID="ReceiveEmails" runat="server" Text="Do you wish to receive emails from us?"></asp:CheckBox>
    </p>
    
    <p>
        <asp:Button ID="SaveCustomerChanges" runat="server" Text="Save Changes" ValidationGroup="EditAccountValidationGroup"
         CausesValidation="true" OnClick="SaveCustomerChanges_Click" />
    </p>          
   
    <p style="color:Blue;">
        <asp:Label runat="server" Text="Account Edited Successfully" Visible="false" ID="StatusLabel"/>
    </p>
   
   
    <asp:CustomValidator runat="server" ID="CustomValidatorUpdateAccount" ValidationGroup="EditAccountValidationGroup" 
    ErrorMessage="" Text="" visible="false"/>

</div>    
<div class="clearfix"></div></div><!-- end mainWithSideBar --></asp:Content>  