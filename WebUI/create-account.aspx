<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.master" AutoEventWireup="True" CodeBehind ="create-account.aspx.cs" Inherits="WebUI.CreateAcct" Title="Create an Account - Nova Registration"%>

<asp:Content ID="Header" ContentPlaceHolderID="Header" runat="server">
    <link rel="canonical" href="http://www.novausawood.com" />

    <title>Register with Nova USA Wood Products</title>
    <meta name="Description" content="Register on our web site so we can list you as a reseller of our products - or simply register so we can share information." />
    <meta name="Keywords" content="register, nova usa, web site, resellers, where to buy, listing" />

    <meta name="p:domain_verify" content="0381711ecc28fc8a9d9a119f7c8fb0f1"/>
</asp:Content>

<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
<div id="mainWithSideBar">

<script type="text/javascript">
<!--
    function toggle_visibility(id) {
       var e = document.getElementById(id);
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
    }
    function show_element(id) {
       var e = document.getElementById(id);
       e.style.display = 'block';
    }
    function hide_element(id) {
       var e = document.getElementById(id);
       e.style.display = 'none';
    }
//-->
</script>

    <h1>Register with Nova</h1>
    <h2><a href="#" onclick="show_element('home-owners-text'); hide_element('architects-text'); hide_element('installer-text'); hide_element('dealer-text'); hide_element('distributor-text');">Home Owners</a></h2>
    <p id="home-owners-text" style="display:none;">Registering with us will put you in our contact database. We'll keep you up to date on our new product offerings via email and we'll assign you to one of our sales professionals to help answer any questions. When filling out the form below, just let us know what products and services you are interested in.</p>
    <h2><a href="#" onclick="hide_element('home-owners-text'); show_element('architects-text'); hide_element('installer-text'); hide_element('dealer-text'); hide_element('distributor-text');">Architects and Designers</a></h2>
    <p id="architects-text" style="display:none;">Once approved, your registration with Nova will allow you to have a listing on our web site. Home owners are always looking for design professionals who have experience working with our products. Our database of design professionals is a great way to get your company in front of prospective customers. We'll be happy to help educate you regarding our products and can provide literature and samples. Architectural specification guides are available for download as well.</p>
    <h2><a href="#" onclick="hide_element('home-owners-text'); hide_element('architects-text'); show_element('installer-text'); hide_element('dealer-text'); hide_element('distributor-text');">Installers, Contractors and Builders</a></h2>
    <p id="installer-text" style="display:none;">Installation professionals should register with us so you can be found by prospective clients. We require that every listing for installation professionals be approved by one of our sales professionals so that we can refer clients to you with the highest degree of confidence. We're here to help educate you on our products so please let us know how we can help.</p>
    <h2><a href="#" onclick="hide_element('home-owners-text'); hide_element('architects-text'); hide_element('installer-text'); show_element('dealer-text'); hide_element('distributor-text');">Dealers and Retailers</a></h2>
    <p id="dealer-text" style="display:none;">We have hundreds of unique vistors on our web site every day. Our goal is to efficiently refer consumers directly to retailers who understand and promote Nova's products. Once approved, you will have a dedicated web page on our site. Home owners will be able to go directly to your web site from ours. We'll keep you up to date with our newest product offerings and industry trends.</p>
    <h2><a href="#" onclick="hide_element('home-owners-text'); hide_element('architects-text'); hide_element('installer-text'); hide_element('dealer-text'); show_element('distributor-text');">Wholesale Distributors</a></h2>
    <p id="distributor-text" style="display:none;">Registering with us will put you in our contact database and we'll assign a sales professional to you. We support many of our full-line stocking distributors on an exclusive basis in their region. However, many of our product lines are still available to new distributors. Once established as a stocking Nova distributor, we can upload your dealer list to our web site to assist with the promotion of our products. Feel free to register or call us for more information.</p>
    <p><a href="edit-account.aspx">Click here if you already signed up and would like to edit your registration with us.</a></p>
    <div id="login">
        <h2>Please enter as much information as possible to complete your registration:</h2>
        <table width="490px" style="float:left;">
            <tr>
                <td align="right">Email Address:</td>
                <td>
                    <asp:TextBox  width="200px" runat="server" ID="CreateEmail"/>
                    <asp:RequiredFieldValidator ValidationGroup="CreateAccountValidationGroup" enableclientscript="true" Display="Dynamic" ID="CreateEmailRequired" ErrorMessage="Email Address is a required field" ControlToValidate="CreateEmail" runat="server">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ValidationGroup="CreateAccountValidationGroup" enableclientscript="true" Display="Dynamic" ID="CreateEmaildRegex" ErrorMessage="Email Address is invalid" ControlToValidate="CreateEmail" runat="server" ValidationExpression="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$">*</asp:RegularExpressionValidator>
                </td>
            </tr> 
            <tr>
                <td align="right">First Name:</td>
                <td>
                    <asp:TextBox  width="200px" runat="server" ID="CreateFirstName"/>
                    <asp:RequiredFieldValidator ValidationGroup="CreateAccountValidationGroup" enableclientscript="true" Display="Static" ID="CreateFirstRequired" ErrorMessage="First Name is a required field" ControlToValidate="CreateFirstName" runat="server">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right">Last Name:</td>
                <td>
                    <asp:TextBox  width="200px" runat="server" ID="CreateLastName"/>
                    <asp:RequiredFieldValidator ValidationGroup="CreateAccountValidationGroup" Display="Static" ID="CreateLastRequired" ErrorMessage="Last Name is a required field" ControlToValidate="CreateLastName" runat="server">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right">Company Name:</td>
                <td>
                    <asp:TextBox width="300px" runat="server" ID="CreateCompanyName"/>
                </td>
            </tr>
            <tr>
                <td align="right">Address 1:</td>
                <td>
                    <asp:TextBox width="300px" runat="server" ID="CreateAddress1"/>
                </td>
            </tr>
            <tr>
                <td align="right">Address 2:</td>
                <td>
                    <asp:TextBox width="300px" runat="server" ID="CreateAddress2"/>
                </td>
            </tr>
            <tr>
                <td align="right">City, State, Zip:</td>
                <td>
                    <asp:TextBox width="194px" runat="server" ID="CreateCity"/>
                    <asp:TextBox width="30px" runat="server" ID="CreateState"/>
                    <asp:TextBox width="60px" runat="server" ID="CreateZIP"/>
                </td>
            </tr>
            <tr>
                <td align="right">Country:</td>
                <td>
                    <asp:TextBox width="300px" runat="server" ID="CreateCountry"/>
                </td>
            </tr>
            <tr>
                <td align="right">Phone:</td>
                <td>
                    <asp:TextBox width="150px" runat="server" ID="CreatePhone"/>
                </td>
            </tr>
            <tr>
                <td align="right">FAX:</td>
                <td>
                    <asp:TextBox width="150px" runat="server" ID="CreateFAX"/>
                </td>
            </tr>
            <tr>
                <td align="right">Website:</td>
                <td>
                    <asp:TextBox width="150px" runat="server" ID="CreateWebsite"/>
                </td>
            </tr>
            <tr>
                <td align="right">Password:</td>
                <td>
                    <asp:TextBox width="150px" TextMode="password" runat="server" ID="CreatePassword"  />
                    <asp:RequiredFieldValidator ValidationGroup="CreateAccountValidationGroup" Display="Static" ID="CreatePasswordRequired" ErrorMessage="Password is a required field" ControlToValidate="CreatePassword" runat="server">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right">Confirm Password:</td>
                <td>
                    <asp:TextBox width="150px" TextMode="Password" runat="server" ID="CreateConfirmPassword" />
                    <asp:CompareValidator ValidationGroup="CreateAccountValidationGroup" Display="Static" ID="ConfirmPasswordMatch" ErrorMessage="Confirm password must match the password" ControlToCompare="CreatePassword" ControlToValidate="CreateConfirmPassword" runat="server">*</asp:CompareValidator>
                </td>
            </tr>
            <tr><td>&nbsp</td></tr>
            <tr>
                <td align="right" class="receive-email-box">
                    <asp:CheckBox ID="CreateReceiveEmails" runat="server" Checked="true"  />
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
                    <asp:RadioButtonList RepeatColumns="2" style="width:300px;" ID="CreateAccountType" runat="server">
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
                <td><asp:TextBox ID="CreateReference" style="margin-top:10px;" runat="server" width="300"></asp:TextBox></td>
            
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
                    <asp:CheckBoxList RepeatColumns="2" style="width:340px;" ID="CreateProductCategory" runat="server">
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
                    <asp:CheckBoxList RepeatColumns="2" style="width:340px;" ID="CreateSpeciesList" runat="server">
                        <asp:listitem Text="Red Oak" Value="1" />
                        <asp:listitem Text="White Oak" Value="2" />
                        <asp:listitem Text="Maple" Value="3" />
                        <asp:listitem Text="Birch" Value="4" />
                        <asp:listitem Text="Walnut" Value="5" />
                        <asp:listitem Text="Hickory" Value="6" />
                        <asp:listitem Text="Cherry" Value="24" />
                        <asp:listitem Text="Tigerwood" Value="7" />
                        <asp:listitem Text="Amendoim" Value="8" />
                        <asp:listitem Text="Kurupayra" Value="9" />
                        <asp:listitem Text="Ipe" Value="10" />
                        <asp:listitem Text="Morado" Value="11" />
                        <asp:listitem Text="Bloodwood" Value="23" />
                        <asp:listitem Text="Douglas Fir" Value="25" />
                        
                        <asp:listitem Text="Brazilian Cherry, Jatoba" Value="12" />
                        <asp:listitem Text="Guajara" Value="27" />
                        <asp:listitem Text="Brazilian Walnut, Ipe" Value="13" />
                        <asp:listitem Text="Brazilian Teak, Cumaru" Value="14" />
                        <asp:listitem Text="Brazilian Chestnut, Red Cumaru" Value="15" />
                        <asp:listitem Text="Brazilian Redwood, Massaranduba" Value="16" />
                        <asp:listitem Text="Royal Mahogany, Andiroba" Value="17" />
                        <asp:listitem Text="Santos Mahogany, Cabreuva" Value="22" />
                        <asp:listitem Text="Para Rosewood, Macacauba" Value="18" />
                        <asp:listitem Text="Patagonian Rosewood, Curupau" Value="19" />
                        <asp:listitem Text="Tarara, Canarywood" Value="20" />
                        <asp:listitem Text="Tiete Rosewood, Sirari" Value="21" />
                        <asp:listitem Text="Timborana" Value="26" />
                        <asp:listitem Text="Batu, Red Balau" Value="28" />                        
                    </asp:CheckBoxList>
                </td>
            </tr>        
            <tr>
                <td align="right">Services:</td>
                <td align="left" class="radio-buttons" style="border-top: solid 2px #333;">
                    <asp:CheckBoxList RepeatColumns="2" style="width:340px;" ID="CreateServicesList" runat="server">
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
                    <asp:TextBox  width="330px" TextMode="MultiLine" runat="server" ID="CreateAbout"/>
                </td>
            </tr> 
            <tr>
                <td align="right">Tagline:</td>
                <td>
                    <asp:TextBox  width="330px" TextMode="MultiLine" runat="server" ID="CreateTagline"/>
                </td>
            </tr> 
            <tr>
                <td align="left"> &nbsp; </td>
                <td class="create-account-button" style="padding-top:10px;">
                    <asp:Button ID="CreateAccount" ValidationGroup="CreateAccountValidationGroup" OnClick="CreateAccount_Click" runat="server" Text="Register" CausesValidation="true" />
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

