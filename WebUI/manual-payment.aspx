<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="manual-payment.aspx.cs" Inherits="WebUI.manual_payment" Title="Manual Payment - PayPal" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server"><div id="mainWithSideBar">

<div id="checkout-outer" style="padding-left:30px;">
    <div id="checkout">

            <h2>Billing Address:</h2>
            <table>
                <tr>
                    <td width="110px" align="left">First Name:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="BillingFirstName" runat="server" CausesValidation="true" TabIndex="1" />
                        <asp:RequiredFieldValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="BillingFirstNameRequired" 
                            ErrorMessage="First Name Is required!"
                            Text="*"
                            runat="server" 
                            ControlToValidate="BillingFirstName" 
                        />
                    </td>
                </tr>
                <tr>                    
                    <td align="left">Last Name:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="BillingLastName" runat="server" CausesValidation="true" TabIndex="2" />
                        <asp:RequiredFieldValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="BillingLastNameRequired" 
                            ErrorMessage="Last Name Is required!"
                            Text="*"
                            runat="server" 
                            ControlToValidate="BillingLastName" 
                        />
                    </td>                            
                </tr>
                <tr>
                    <td align="left">Address 1:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="BillingAddress1" runat="server" CausesValidation="true" TabIndex="3"/>
                        <asp:RequiredFieldValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="BillingAddress1Required" 
                            ErrorMessage="Address 1 Is required!"
                            Text="*"
                            runat="server" 
                            ControlToValidate="BillingAddress1" 
                        />
                    </td>
                </tr>
                <tr>                    
                    <td align="left">Address 2:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="BillingAddress2" runat="server" CausesValidation="true" TabIndex="4"/>
                    </td>
                </tr>
                <tr>                    
                    <td align="left">City:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="BillingCity" runat="server" CausesValidation="true" TabIndex="7"/>
                        <asp:RequiredFieldValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="BillingCityRequired" 
                            ErrorMessage="City Is required!"
                            Text="*"
                            runat="server" 
                            ControlToValidate="BillingCity" 
                        />
                    </td>
                </tr>
                <tr>
                    <td align="left">State:</td>
                    <td align="left">
                        <asp:DropDownList ID="BillingState" runat="server" CausesValidation="true" TabIndex="8" />
                    </td>
                </tr>
                <tr>
                <td align="left">Zip Code:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="BillingZipCode" runat="server" CausesValidation="true" TabIndex="9"/>
                        <asp:RequiredFieldValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="BillingZipCodeRequired" 
                            ErrorMessage="Zip Code Is required!" 
                            Text="*"
                            runat="server" 
                            ControlToValidate="BillingZipCode" 
                        />
                        <asp:RegularExpressionValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="BillingZipCodeRegex" 
                            ErrorMessage="Zip Code must be a valid zip code in the United States or Canada"
                            Text="*"
                            runat="server" 
                            ControlToValidate="BillingZipCode"
                            ValidationExpression="^(((\d{5}-\d{4})|(\d{5}))|([A-Z]\d[A-Z]\s\d[A-Z]\d))$" 
                        /><!-- Validates a zip code -->
                    </td>
                </tr>
                <tr>
                    <td align="left">Phone Number:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="BillingPhoneNumber" runat="server" CausesValidation="true" TabIndex="10" />
                        <asp:RequiredFieldValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="BillingPhoneNumberRequired" 
                            ErrorMessage="A Phone number Is required!"
                            Text="*"
                            runat="server" 
                            ControlToValidate="BillingPhoneNumber" 
                        />
                    </td>
                </tr>
                <tr>
                    <td align="left">Fax Number:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="BillingFax" runat="server" CausesValidation="true" TabIndex="11" />
                    </td>
                </tr>
            </table>
            
            <h2>-OR- Select a Previously Used Address:</h2>
            
            <table>
                <tr>
                    <td>
                        <asp:DropDownList 
                            width="290px" 
                            ID="BillingPreviousAddress" 
                            EnableViewState="true"
                            runat="server" 
                            CausesValidation="false" 
                            OnSelectedIndexChanged="BillPrevAddress_Change" 
                            AutoPostBack="true" 
                            TabIndex="12" 
                        />
                    </td>
                </tr>
            </table>
            
             
            <h2>Credit Card Information:</h2>
            <table>
                <tr>
                    <td align="left">
                        <asp:RadioButtonList 
                            ID="CreditCardType" 
                            runat="server" 
                            TabIndex="13"
                        >
                            <asp:ListItem Text="Visa" Value="Visa" Enabled="true" Selected="true" />
                            <asp:ListItem Text="MasterCard" Value="MasterCard" Enabled="true"  />
                            <asp:ListItem Text="Discover" Value="Discover" Enabled="true" />
                            <asp:ListItem Text="Amex" Value="Amex" Enabled="true" />
                        </asp:RadioButtonList>
                    </td>
                </tr>
            </table>
            
            <table>
                 <tr>
                    <td width="120" align="left">Credit Card Number:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="CreditCardNumber" runat="server" CausesValidation="true" TabIndex="14" />
                        <asp:RequiredFieldValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="CreditCardRequired" 
                            runat="server" 
                            ErrorMessage="Credit Card number is required! "
                            Text="*"
                            ControlToValidate="CreditCardNumber" 
                        />
                        <asp:CustomValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="CreditCardValidator" 
                            runat="server"
                            ErrorMessage="Credit Card number may be incorrectly formatted."
                            Text="*"
                            ControlToValidate="CreditCardNumber"
                            OnServerValidate="CreditCardNumber_Validate" 
                            ValidateEmptyText="true"  
                        />
                    </td>
                </tr>
                <tr>
                    <td align="left">Card Security Code:</td>
                    <td align="left">
                        <asp:TextBox width="48px" ID="CreditCardCVV2" runat="server" CausesValidation="true" TabIndex="15" />
                        <asp:RequiredFieldValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="CVV2Required" 
                            ErrorMessage="Security code is required. "
                            Text="*"
                            runat="server" 
                            ControlToValidate="CreditCardCVV2" 
                        />
                        <asp:RegularExpressionValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="CVV2Regex" 
                            ErrorMessage="Security code should be 3 or 4 numbers long."
                            Text="*"
                            ValidationExpression="^(\d{3,4})$"
                            runat="server" 
                            ControlToValidate="CreditCardCVV2" 
                        />
                    </td>
                </tr>
                <tr>
                    <td align="left">Expiration:</td>
                    <td align="left">
                        <asp:DropDownList ID="CreditCardExpirationMonth" runat="server" CausesValidation="true" TabIndex="16" >
                            <asp:ListItem Selected="true" Text="1" Value="1" />
                            <asp:ListItem Text="2" Value="2" />
                            <asp:ListItem Text="3" Value="3" />
                            <asp:ListItem Text="4" Value="4" />
                            <asp:ListItem Text="5" Value="5" />
                            <asp:ListItem Text="6" Value="6" />
                            <asp:ListItem Text="7" Value="7" />
                            <asp:ListItem Text="8" Value="8" />
                            <asp:ListItem Text="9" Value="9" />
                            <asp:ListItem Text="10" Value="10" />
                            <asp:ListItem Text="11" Value="11" />
                            <asp:ListItem Text="12" Value="12" />
                        </asp:DropDownList>
                        /&nbsp
                        <asp:DropDownList ID="CreditCardExpirationYear" runat="server" CausesValidation="true" TabIndex="17" >
                            <asp:ListItem Selected="true" Text="2014" Value="2014" />
                            <asp:ListItem Text="2015" Value="2015" />
                            <asp:ListItem Text="2016" Value="2016" />
                            <asp:ListItem Text="2017" Value="2017" />
                            <asp:ListItem Text="2018" Value="2018" />                            
                            <asp:ListItem Text="2019" Value="2019" />                            
                            <asp:ListItem Text="2020" Value="2020" />                            
                            <asp:ListItem Text="2021" Value="2021" />                            
                            <asp:ListItem Text="2022" Value="2022" />                            
                            <asp:ListItem Text="2023" Value="2023" />                            
                            <asp:ListItem Text="2024" Value="2024" />                            
                            <asp:ListItem Text="2025" Value="2025" />                            
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            
            <p style="color:Red; font-size:.9em; padding-top:4px;" >
                Credit card information is not saved to the server. If you close your browser, 
                you will be required to re-enter this information.
            </p>
            
            <table style="margin-bottom:30px;">
                <tr>
                    <td width="120" align="left">Referral Code:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="ReferralCode" runat="server" CausesValidation="false" TabIndex="18" />
                    </td>
                </tr>
                <tr>
                    <td width="120" align="left">Amount to Pay:</td>
                    <td align="left">
                        <asp:TextBox width="80px" ID="Amount" runat="server" CausesValidation="false" TabIndex="19" />
                    </td>
                </tr>
            </table>
            
            <asp:Button ForeColor="Black" width="150" runat="server" ID="ProcessPayment" OnClick="processPayment_Click" Text="Process Payment" />
            
            <asp:Label ID="PaypalError" runat="server" ForeColor="red" Visible="false" />
    </div>

    
    <div class="hints" style="padding-top:20px;">
        <h2>Helpful Hints</h2>
        <ul>
            <li>You are now in the manual payment window.</li>
            <li>Please enter a billing address or choose a billing address from the drop down box.</li>
            <li>Please enter the complete credit card information which will be transmitted to us via PayPal.</li>
            <li>Enter the amount of money you are sending to us.</li>
            <li>Please let us know if we can help you in any way.</li>
        </ul>

        <h2>Questions?</h2>
        <ul class="questions">
            <li>Our knowledgable staff is ready to help.</li>
            <li>Call us at 888.448.9663</li>
        </ul>

    </div>


</div>

<div class="clearfix"></div></div><!-- end mainWithSideBar --></asp:Content>  