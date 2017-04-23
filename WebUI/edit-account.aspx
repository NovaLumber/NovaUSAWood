<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="edit-account.aspx.cs" Inherits="WebUI.edit_account" Title="Untitled Page" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
<div id="mainWithSideBar">

    <h1>Edit Account Information</h1>

    <div id="login">
        <h2>Please update your registration information below:</h2>
        
        <table width="490px" style="float:left;">
            <tr>
                <td align="right">Email Address:</td>
                <td>
                    <asp:TextBox  width="200px" runat="server" ID="Email"/>
                    <asp:RequiredFieldValidator ValidationGroup="CreateAccountValidationGroup" enableclientscript="true" Display="Dynamic" ID="CreateEmailRequired" ErrorMessage="Email Address is a required field" ControlToValidate="Email" runat="server">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ValidationGroup="CreateAccountValidationGroup" enableclientscript="true" Display="Dynamic" ID="CreateEmaildRegex" ErrorMessage="Email Address is invalid" ControlToValidate="Email" runat="server" ValidationExpression="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$">*</asp:RegularExpressionValidator>
                </td>
            </tr> 
            <tr>
                <td align="right">First Name:</td>
                <td>
                    <asp:TextBox  width="200px" runat="server" ID="FirstName"/>
                    <asp:RequiredFieldValidator ValidationGroup="CreateAccountValidationGroup" enableclientscript="true" Display="Static" ID="CreateFirstRequired" ErrorMessage="First Name is a required field" ControlToValidate="FirstName" runat="server">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right">Last Name:</td>
                <td>
                    <asp:TextBox  width="200px" runat="server" ID="LastName"/>
                    <asp:RequiredFieldValidator ValidationGroup="CreateAccountValidationGroup" Display="Static" ID="CreateLastRequired" ErrorMessage="Last Name is a required field" ControlToValidate="LastName" runat="server">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right">Company Name:</td>
                <td>
                    <asp:TextBox width="300px" runat="server" ID="CompanyName"/>
                </td>
            </tr>
            <tr>
                <td align="right">Address 1:</td>
                <td>
                    <asp:TextBox width="300px" runat="server" ID="Address1"/>
                </td>
            </tr>
            <tr>
                <td align="right">Address 2:</td>
                <td>
                    <asp:TextBox width="300px" runat="server" ID="Address2"/>
                </td>
            </tr>
            <tr>
                <td align="right">City, State, Zip:</td>
                <td>
                    <asp:TextBox width="194px" runat="server" ID="City"/>
                    <asp:TextBox width="30px" runat="server" ID="State"/>
                    <asp:TextBox width="60px" runat="server" ID="ZIP"/>
                </td>
            </tr>
            <tr>
                <td align="right">Country:</td>
                <td>
                    <asp:TextBox width="300px" runat="server" ID="Country"/>
                </td>
            </tr>
            <tr>
                <td align="right">Phone:</td>
                <td>
                    <asp:TextBox width="150px" runat="server" ID="Phone"/>
                </td>
            </tr>
            <tr>
                <td align="right">FAX:</td>
                <td>
                    <asp:TextBox width="150px" runat="server" ID="FAX"/>
                </td>
            </tr>
            <tr>
                <td align="right">Website:</td>
                <td>
                    <asp:TextBox width="150px" runat="server" ID="Website"/>
                </td>
            </tr>
            <tr>
                <td align="right" class="receive-email-box">
                    <asp:CheckBox ID="ReceiveEmails" runat="server" Checked="true"  />
                </td>
                <td align="left" class="receive-emails">
                    Receive emails from us regarding <br />
                    special offers and information
                </td>
            </tr>
            <tr><td>&nbsp</td></tr>
            <tr>
                <td align="right">Register as a:</td>
                <td align="left" class="radio-buttons">
                    <asp:RadioButtonList RepeatColumns="2" style="width:300px;" ID="AccountType" runat="server">
                        <asp:listitem Selected="true" Text="Home Owner" Value="1" />
                        <asp:listitem Text="Installer, Contractor" Value="2" />
                        <asp:listitem Text="Builder" Value="3" />
                        <asp:listitem Text="Retailer or Dealer" Value="4" />
                        <asp:listitem Text="Distributor" Value="5" />
                        <asp:listitem Text="Architect, Designer" Value="7" />
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="padding-top:10px;">How did you hear about us?</td>
                <td><asp:TextBox ID="Reference" style="margin-top:10px;" runat="server" width="300"></asp:TextBox></td>
            
            </tr>
            <tr>
                <td colspan="2">
                    <asp:CustomValidator runat="server" ID="CustomValidatorCreateAccount" ValidationGroup="CreateAccountValidationGroup" ErrorMessage="" Text="" visible="false"/>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td align="right" style="color:Red;">
                    <asp:CustomValidator runat="server" ID="CustomValidatorLogin" ValidationGroup="LoginValidationGroup" ErrorMessage="" Text="" visible="false"/>
                </td>
            </tr>
            
        </table>
        
        <table width="440px" style="float:left;">
            <tr>
                <td align="right">Products:</td>
                <td align="left" class="radio-buttons">
                    <asp:CheckBoxList RepeatColumns="2" style="width:340px;" ID="ProductCategory" runat="server">
                        <asp:listitem Text="Solid Hardwood Flooring" Value="1" />
                        <asp:listitem Text="Engineered Wood Flooring" Value="2" />
                        <asp:listitem Text="Prefinished Flooring" Value="3" />
                        <asp:listitem Text="Unfinished Flooring" Value="4" />
                        <asp:listitem Text="Exterior Wood Decking" Value="5" />
                    </asp:CheckBoxList>
                </td>
            </tr>        
            <tr>
                <td align="right">Wood Species:</td>
                <td align="left" class="radio-buttons" style="border-top: solid 2px #333;">
                    <asp:CheckBoxList RepeatColumns="2" style="width:340px;" ID="SpeciesList" runat="server">
                        <asp:listitem Text="Red Oak" Value="1" />
                        <asp:listitem Text="White Oak" Value="2" />
                        <asp:listitem Text="Maple" Value="3" />
                        <asp:listitem Text="Birch" Value="4" />
                        <asp:listitem Text="Walnut" Value="5" />
                        <asp:listitem Text="Hickory" Value="6" />
                        <asp:listitem Text="Cherry" Value="7" />
                        <asp:listitem Text="Tigerwood" Value="8" />
                        <asp:listitem Text="Amendoim" Value="9" />
                        <asp:listitem Text="Kurupayra" Value="10" />
                        <asp:listitem Text="Lapacho Ipe" Value="11" />
                        <asp:listitem Text="Morado" Value="12" />
                        <asp:listitem Text="Bloodwood" Value="13" />
                        <asp:listitem Text="Douglas Fir" Value="14" />
                        
                        <asp:listitem Text="Brazilian Cherry, Jatoba" Value="15" />
                        <asp:listitem Text="Brazilian Cherry Light, Guajara" Value="16" />
                        <asp:listitem Text="Brazilian Walnut, Ipe" Value="17" />
                        <asp:listitem Text="Brazilian Teak, Cumaru" Value="18" />
                        <asp:listitem Text="Brazilian Chestnut, Red Cumaru" Value="19" />
                        <asp:listitem Text="Brazilian Redwood, Massaranduba" Value="20" />
                        <asp:listitem Text="Royal Mahogany, Andiroba" Value="21" />
                        <asp:listitem Text="Santos Mahogany, Cabreuva" Value="22" />
                        <asp:listitem Text="Para Rosewood, Macacauba" Value="23" />
                        <asp:listitem Text="Patagonian Rosewood, Curupau" Value="24" />
                        <asp:listitem Text="Tarara, Canarywood" Value="25" />
                        <asp:listitem Text="Tiete Rosewood, Sirari" Value="26" />
                        <asp:listitem Text="Timborana" Value="27" />
                        <asp:listitem Text="Batu, Red Balau" Value="28" />
                    </asp:CheckBoxList>
                </td>
            </tr>        
            <tr>
                <td align="right">Services:</td>
                <td align="left" class="radio-buttons" style="border-top: solid 2px #333;">
                    <asp:CheckBoxList RepeatColumns="2" style="width:340px;" ID="ServicesList" runat="server">
                        <asp:listitem Text="Retail Store" Value="1" />
                        <asp:listitem Text="Internet Shopping Site" Value="2" />
                        <asp:listitem Text="Interior Design" Value="3" />
                        <asp:listitem Text="Architectural Design" Value="4" />
                        <asp:listitem Text="Installation Services" Value="5" />
                        <asp:listitem Text="General Contractor" Value="6" />
                    </asp:CheckBoxList>
                </td>
            </tr>        
            <tr>
                <td align="right">About your company:</td>
                <td>
                    <asp:TextBox  width="330px" TextMode="MultiLine" runat="server" ID="About"/>
                </td>
            </tr> 
            <tr>
                <td align="right">Tagline:</td>
                <td>
                    <asp:TextBox  width="330px" TextMode="MultiLine" runat="server" ID="Tagline"/>
                </td>
            </tr>            
            <tr>
                <td align="left"> &nbsp; </td>
                <td class="update-account-button" style="padding-top:10px;">
                    <asp:Button ID="UpdateAccount" ValidationGroup="CreateAccountValidationGroup" OnClick="UpdateAccount_Click" runat="server" Text="Update" CausesValidation="true" />
                </td>
            </tr>     
            <tr><td></td><td>
                <asp:ValidationSummary ID="loginValidationSummary" runat="server" ValidationGroup="LoginValidationGroup" CssClass="ErrorMessages" DisplayMode="BulletList"/>
                <asp:ValidationSummary ID="createUserValidationSummary" runat="server" ValidationGroup="CreateAccountValidationGroup" CssClass="ErrorMessages" DisplayMode="BulletList"/>
                <asp:HiddenField ID="Referrer" runat="server" Value="thank-you.aspx"/>            
            </td></tr>               
        </table>        

<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->
</asp:Content>  