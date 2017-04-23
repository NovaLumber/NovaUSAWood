<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.master" AutoEventWireup="True" CodeBehind ="Login.aspx.cs" Inherits="WebUI.Login" Title="novausawood.com - Login"%>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
<div id="mainWithSideBar">
<h1>Please login to continue</h1>

<div id="login">

        <asp:ValidationSummary ID="loginValidationSummary" runat="server" ValidationGroup="LoginValidationGroup" CssClass="ErrorMessages" DisplayMode="BulletList"/>
        <asp:ValidationSummary ID="createUserValidationSummary" runat="server" ValidationGroup="CreateAccountValidationGroup" CssClass="ErrorMessages" DisplayMode="BulletList"/>

        <asp:HiddenField ID="Referrer" runat="server" Value="Default.aspx"/>

    
                    <table width="600px">
                        <tr>
                            <td width="100px" align="right">Email Address:</td>
                            <td align="left">
                                <asp:TextBox width="200px" runat="server" ID="Username"/>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Password:</td>
                            <td align="left">
                                <asp:TextBox  width="200px" TextMode="Password" runat="server" ID="Password"/>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td align="left">
                                <asp:Button 
                                    ID="LoginButton" width="70px" OnClick="LoginButton_Click" 
                                    ValidationGroup="LoginValidationGroup" runat="server" 
                                    Text="Login" CausesValidation="false"  />
                            </td>
                        </tr>

                        <tr>
                            <td>&nbsp;</td>
                            <td align="left" style="padding-top:25px;">
                                <asp:Button 
                                    ID="ForgotPasswordButton" OnClick="ForgotPasswordButton_Click" 
                                    runat="server" Text="Forgot Password ?" CausesValidation="false" />
                                    
                            </td>
                        </tr>
                        
                        <tr><td></td><td style="padding-top:5px;">If you forgot your password, enter your email address above and click the Forgot Password button.
                        We'll send you an email with a temporary new password. Your old password will still work until you log on successfully with the
                        new password. Once you log on successfully, your password will be permanently changed to the password last used.</td></tr>
                        
                        <tr>
                            <td>&nbsp;</td>
                            <td align="right" style="color:Red;">
                                <asp:CustomValidator runat="server" ID="CustomValidatorLogin" ValidationGroup="LoginValidationGroup" ErrorMessage="" Text="" visible="false"/>
                            </td>
                        </tr>
                    </table>
    
<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->
</asp:Content>

