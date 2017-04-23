<%@ Page Language="C#" MasterPageFile="~/UiMasterPage.master" AutoEventWireup="True" CodeBehind ="Checkout.aspx.cs" Inherits="WebUI.Checkout" Title="TrailerDecking.com - Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">

<div id="checkout-outer">
<div id="checkout">
<asp:ValidationSummary ID="checkoutWizardValidationSummary" runat="server" DisplayMode="BulletList" CssClass="ErrorMessages"/>
<asp:Wizard 
    ID="CheckoutWizard" 
    runat="server" 
    HeaderText="" 
    OnNextButtonClick="NextButton_Click" 
    OnFinishButtonClick="NextButton_Click"
>
    <StepStyle VerticalAlign="top" HorizontalAlign="left" />
    <SideBarStyle VerticalAlign="Top" HorizontalAlign="left" Width="160px"  />
    <NavigationButtonStyle/>
    <StepNavigationTemplate>
        <asp:Button 
            ID="StepPreviousButton" 
            width="70" 
            runat="server" 
            CausesValidation="false" 
            CommandName="MovePrevious"
            Text="Previous" 
            TabIndex="20" 
        />
        <asp:Button 
            ID="StepNextButton" 
            width="70" 
            runat="server" 
            CommandName="MoveNext" 
            CausesValidation="true" 
            Text="Next" 
            TabIndex="19"
        />
    </StepNavigationTemplate>
    <StartNavigationTemplate>
        <asp:Button 
            ID="StepNextButton" 
            width="70" 
            runat="server" 
            CommandName="MoveNext" 
            CausesValidation="true" 
            Text="Next" 
            TabIndex="19"
        />
    </StartNavigationTemplate>
    <FinishNavigationTemplate>
        <asp:Button 
            ID="StepPreviousButton" 
            width="70" 
            runat="server" 
            CausesValidation="false" 
            CommandName="MovePrevious"
            Text="Previous" 
            TabIndex="20"
        />
        <asp:Button 
            ID="FinishButton" 
            width="70" 
            runat="server" 
            CommandName="MoveComplete" 
            Text="Finish" 
            TabIndex="19"  
        />
    </FinishNavigationTemplate>
             
    <WizardSteps>
        <asp:WizardStep 
            ID="ShippingAddress" 
            runat="server" 
            Title="Select Shipping Address" 
            OnLoad="ShippingAddress_Load"
        >
            <asp:Label Visible="false" ID="ExpressCheckoutErrorMessage" runat="server"/>
            <h2>Enter A New Address:</h2>
            <table>
                <tr>
                    <td width="110px" align="left">First Name:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="ShippingFirstName" runat="server" CausesValidation="true" TabIndex="1"/>
                        <asp:RequiredFieldValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="ShippingFirstNameRequired" 
                            Text="*"
                            ErrorMessage="First Name Is Required!"
                            runat="server" 
                            ControlToValidate="ShippingFirstName"
                            enableclientscript="false"
                        />
                    </td>
                </tr>
                <tr>                    
                    <td align="left">Last Name:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="ShippingLastName" runat="server" CausesValidation="true" TabIndex="2"/>
                        <asp:RequiredFieldValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="ShippingLastNameRequired" 
                            ErrorMessage="Last Name Is required!"
                            Text="*"
                            runat="server" 
                            ControlToValidate="ShippingLastName"
                            enableclientscript="false"
                        />
                    </td>                             
                </tr>
                <tr>
                    <td align="left">Address:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="ShippingAddress1" runat="server" CausesValidation="true" TabIndex="3" />
                        <asp:RequiredFieldValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="ShippingAddress1Required" 
                            ErrorMessage="Shipping Address Is required!"
                            Text="*"
                            runat="server" 
                            ControlToValidate="ShippingAddress1"
                            enableclientscript="false"
                        />
                    </td>
                </tr>
                <tr>                    
                    <td align="left"></td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="ShippingAddress2" runat="server" CausesValidation="true" TabIndex="4"/>
                    </td>
                    <td align="left"></td> 
                </tr>
                <tr>                    
                    <td align="left">City:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="ShippingCity" runat="server" CausesValidation="true" TabIndex="5"/>
                        <asp:RequiredFieldValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="ShippingCityRequired" 
                            ErrorMessage="City Is required!" 
                            Text="*"
                            EnableClientScript="false"
                            runat="server" 
                            ControlToValidate="ShippingCity" 
                        />
                    </td>
                </tr>
                <tr>
                    <td align="left">State:</td>
                    <td align="left">
                        <asp:DropDownList ID="ShippingState" runat="server" CausesValidation="true" TabIndex="6"/>
                    </td>
                </tr>
                <tr>
                    <td align="left">&nbsp;</td>
                    <td align="left">&nbsp;</td>
                    <td align="left">&nbsp;</td>
                </tr>
                <tr>                    
                    <td align="left">Zip Code:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="ShippingZipCode" runat="server" CausesValidation="true" TabIndex="7"/>
                        <asp:RequiredFieldValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="ShippingZipCodeRequired" 
                            ErrorMessage="Zip Code Is required!"
                            Text="*"
                            runat="server" 
                            ControlToValidate="ShippingZipCode" 
                            EnableClientScript="false"
                        />
                        <asp:RegularExpressionValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="ShippingZipCodeFormat" 
                            ErrorMessage="Zip Code must be a valid zip code in the United States or Canada" 
                            Text="*"
                            runat="server" 
                            ControlToValidate="ShippingZipCode"
                            ValidationExpression="^(((\d{5}-\d{4})|(\d{5}))|([A-Z]\d[A-Z]\s\d[A-Z]\d))$" 
                            EnableClientScript="false"
                        /><!-- Validates a zip code -->
                    </td>
                </tr>
                <tr>
                    <td align="left">Phone Number:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="ShippingPhone" runat="server" CausesValidation="true" TabIndex="8"/>
                        <asp:RequiredFieldValidator 
                            style="color:Red; font-size:.9em;" 
                            ID="ShippingPhoneRequired" 
                            ErrorMessage="A Phone number Is required!"
                            Text="*"
                            runat="server" 
                            ControlToValidate="ShippingPhone" 
                            EnableClientScript="false"
                        />
                    </td>
                </tr>
                <tr>                    
                    <td align="left">Fax Number:</td>
                    <td align="left">
                        <asp:TextBox width="180px" ID="ShippingFax" runat="server" CausesValidation="true" TabIndex="9"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">&nbsp;</td>
                </tr>
            </table>

            <h2>(or)  Select a Previously Used Address:</h2>
            <table>
                <tr>
                    <td>
                        <asp:DropDownList 
                            width="290px" 
                            ID="ShippingPreviousAddress" 
                            EnableViewState="true"
                            runat="server" 
                            CausesValidation="false" 
                            OnSelectedIndexChanged="ShipPrevAddress_Change" 
                            AutoPostBack="true" 
                            TabIndex="10" 
                        />
                    </td>
                </tr>
            </table>
            <h2 style="padding-top:45px;">Additional Freight Options:</h2>
            <table>
                <tr>
                    <td style="padding:5px 0px 0px 0px;">If applicable, please enter the verbal quoted freight from TrailerDecking.com</td>
                </tr>
                <tr>
                    <td style="padding:5px 0px 10px 0px;" align="left"><asp:TextBox width="100px" ID="freightGiven" runat="server" TabIndex="11"/></td>
                </tr>
                <tr style="line-height:30px; font-weight:normal;"><td><asp:CheckBox runat="server" width="200px" Text="Is this a residential delivery? " TextAlign="Left" ID="residentialCheckBox" /></td></tr>
            </table>
            <!--
            <h2>-OR-</h2>
            <table>
                <tr>
                    <td>
                        <asp:ImageButton 
                            runat="server" 
                            ID="ExpressCheckout" 
                            ImageUrl="https://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif" 
                            align="left"
                            OnClick="ExpressCheckout_Click" 
                            style="margin-right:7px;" 
                            CausesValidation="false" 
                        />
                    </td>
                </tr>
            </table>
            -->
        </asp:WizardStep>
        
        <asp:WizardStep 
            ID="ShippingOptions" 
            runat="server" 
            Title="Shipping Options" 
            OnLoad="ShippingOptions_Load"
        >
            <h2>Please Select your Shipping Option:</h2>
            <asp:RadioButtonList ID="ShippingRadioButtons" runat="server" TabIndex="5" TextAlign="Right" CssClass="shipping-options-rb-list" />
        </asp:WizardStep>
        
        <asp:WizardStep 
            ID="PaymentOptions" 
            runat="server" 
            Title="Payment Options" 
            OnLoad="PaymentOptions_Load"
        >
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
                            TabIndex=12 
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
                        <asp:DropDownList ID="CreditCardExpirationYear" runat="server" CausesValidation="true" TabIndex="17" />
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
            </table>


        </asp:WizardStep>
        
        <asp:WizardStep 
            ID="CompleteSale" 
            runat="server" 
            Title="Complete Sale" 
            OnLoad="CompleteSale_Load"
        >
        
        <h2>Please confirm address details below, then click 'finish' to complete your order.</h2>
        <asp:LinkButton 
            ID="CompleteSaleError1" 
            OnClick="CompleteSaleError_Click" 
            runat="server" 
            ForeColor="red" 
            Visible="false" 
            Text="The Shipping Address is incomplete, please click here to correct this." 
        />
        
        <% if (CompleteSaleError1.Visible) Response.Write("<br/>"); %>
        
        <asp:LinkButton 
            ID="CompleteSaleError2" 
            OnClick="CompleteSaleError_Click" 
            runat="server" 
            ForeColor="red" 
            Visible="false" 
            Text="The Shipping option is not correctly indicated, please click here to correct this."
        />
        
        <% if (CompleteSaleError2.Visible) Response.Write("<br/>"); %>
        
        <asp:LinkButton 
            ID="CompleteSaleError3" 
            OnClick="CompleteSaleError_Click" 
            runat="server" 
            ForeColor="red" 
            Visible="false" 
            Text="The Billing Address is incomplete, please click here to correct this."
        />
        
        <% if (CompleteSaleError3.Visible) Response.Write("<br/>"); %>
        
        <asp:LinkButton 
            ID="CompleteSaleError4" 
            OnClick="CompleteSaleError_Click" 
            runat="server" 
            ForeColor="red" 
            Visible="false" 
            Text="The Credit Card Information is incomplete, please click here to correct this."
        />
        
        <% if (CompleteSaleError4.Visible) Response.Write("<br/>"); %>
        
        <asp:Label 
            ID="DataChangedError" 
            runat="server" 
            ForeColor="red" 
            Visible="false" 
            Text="While submitting the order, the charges have changed, please review the order, and click finish." 
        />
        
        <% if (DataChangedError.Visible) Response.Write("<br/>"); %>
        
        <asp:Label ID="PaypalError" runat="server" ForeColor="red" Visible="false" />
        <asp:Repeater id="CartRepeater" runat="server" EnableViewState="true">
            <HeaderTemplate>
                <div class="CartViewCenter">
                    <h2>Shopping Cart</h2>
                    <table>
                        <thead class="CartHead">
                            <tr style="line-height:25px;">
                                <td width="500"><b>Description</b></td>
                                <td width="100" style="text-align:right;"><b>Quantity</b></td>
                                <td width="140" style="text-align:right;"><b>Unit Price</b></td>
                                <td width="140" style="text-align:right;"><b>Total Price</b></td>
                                <td width="140" style="text-align:right;"><b>Weight</b></td>
                            </tr>
                        </thead>
                        <!-- tfoot should be declared before tbody -->
                        <tfoot class="CartFoot">
                            <tr style="line-height:35px;">
                                <td style="text-align:right;"><b>Merchandise Totals:</b></td>
                                <td id="CartViewItemCount" style="text-align:right;"><b><%=this.CartRow.ItemCount %></b></td>    
                                <td style="text-align:right;"><b><%=this.CartRow.WeightTotal.ToString() %> lb</b></td>
                                <td style="text-align:right;" id="CartViewTotal"><b><%=this.CartRow.OrderSubTotal.ToString("C") %></b></td>
                                <td style="text-align:right;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="3" style="text-align:right">Sales Tax (<%=TaxPercent %>%):</td>
                                <td style="text-align:right"><%=TaxCost.ToString("C") %></td>
                            </tr>
                            <tr>
                                <td colspan="3" style="text-align:right">
                                    Shipping Cost(<%=m_Order.IsShippingOptionNull()?"None elected":GetShippingOptionById(m_Order.ShippingOption).Name%>):
                                </td>
                                <td style="text-align:right">
                                    <%=m_Order.IsShippingOptionNull()?"0.00":GetShippingOptionById(m_Order.ShippingOption).Cost.ToString("C")%>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" style="text-align:right">Total:</td>
                                <td style="text-align:right">
                                    <%=(this.CartRow.OrderSubTotal + ((m_Order.IsShippingOptionNull())?0:GetShippingOptionById(m_Order.ShippingOption).Cost)+TaxCost).ToString("C") %>
                                </td>
                            </tr>
                        </tfoot>
                        <tbody>
            </HeaderTemplate>
            
            <ItemTemplate>
            
                        <tr class="CartBody">
                            <td class="CartDesc">
                                <%# ((BusinessTier.DataAccessLayer.Cart.CartLineRow)((System.Data.DataRowView)Container.DataItem).Row).Description%>
                            </td>
                            <td style="text-align:right;">
                                <input 
                                    type="hidden"
                                    id="ProductId"
                                    value="<%#((BusinessTier.DataAccessLayer.Cart.CartLineRow)((System.Data.DataRowView)Container.DataItem).Row).ProdId%>"
                                    runat="server" 
                                />
                                <%#((BusinessTier.DataAccessLayer.Cart.CartLineRow)((System.Data.DataRowView)Container.DataItem).Row).Quantity%>
                            </td>
                            <td style="text-align:right;">
                                <%# ((BusinessTier.DataAccessLayer.Cart.CartLineRow)((System.Data.DataRowView)Container.DataItem).Row).Price.ToString("C")%>
                            </td>
                            <td style="text-align:right;">
                                <%#(((BusinessTier.DataAccessLayer.Cart.CartLineRow)((System.Data.DataRowView)Container.DataItem).Row).Price * ((BusinessTier.DataAccessLayer.Cart.CartLineRow)((System.Data.DataRowView)Container.DataItem).Row).Quantity).ToString("C")%>
                            </td>
                            <td style="text-align:right;">
                                <%#((BusinessTier.DataAccessLayer.Cart.CartLineRow)((System.Data.DataRowView)Container.DataItem).Row).Weight.ToString() %> lb
                            </td>
                        </tr>
            </ItemTemplate>

            <FooterTemplate>
                        </tbody>
                    </table>
                </div>
            </FooterTemplate>
                            
        </asp:Repeater>
        
        <asp:HiddenField ID="CalculatedTotal" runat="server" />
        <br />
        <h2>Address Information</h2>

                <h2>Billing Address</h2>
                <ul>
                    <li><%=(OrderBillingAddress==null || OrderBillingAddress.Iscust_addr_1Null())?"":OrderBillingAddress.cust_addr_1%></li>
                    <li><%=(OrderBillingAddress == null || OrderBillingAddress.Iscust_addr_2Null()) ? "" : OrderBillingAddress.cust_addr_2%></li>
                    <li><%=(OrderBillingAddress == null || OrderBillingAddress.Iscust_cityNull()) ? "" : OrderBillingAddress.cust_city%>,
                        <%=(OrderBillingAddress == null || OrderBillingAddress.Iscust_stateNull()) ? "" : OrderBillingAddress.cust_state%>
                        <%=(OrderBillingAddress == null || OrderBillingAddress.Iscust_zipNull()) ? "" : OrderBillingAddress.cust_zip%></li>
                    <li>Phone: <%=(OrderBillingAddress == null || OrderBillingAddress.Iscust_phoneNull()) ? "" : OrderBillingAddress.cust_phone%></li>
                    <li>Fax: <%= (OrderBillingAddress == null || OrderBillingAddress.Iscust_faxNull()) ? "" : OrderBillingAddress.cust_fax%></li>
                </ul>

                <h2>Shipping Address</h2>
                <ul>
                    <li><%=(OrderShippingAddress == null || OrderShippingAddress.Iscust_addr_1Null()) ? "" : OrderShippingAddress.cust_addr_1%></li>
                    <li><%=(OrderShippingAddress == null || OrderShippingAddress.Iscust_addr_2Null()) ? "" : OrderShippingAddress.cust_addr_2%></li>
                    <li><%=(OrderShippingAddress == null || OrderShippingAddress.Iscust_cityNull()) ? "" : OrderShippingAddress.cust_city%>,
                        <%=(OrderShippingAddress == null || OrderShippingAddress.Iscust_stateNull()) ? "" : OrderShippingAddress.cust_state%> 
                        <%=(OrderShippingAddress == null || OrderShippingAddress.Iscust_zipNull()) ? "" : OrderShippingAddress.cust_zip%></li>
                    <li>Phone: <%=(OrderShippingAddress == null || OrderShippingAddress.Iscust_phoneNull()) ? "" : OrderShippingAddress.cust_phone%></li>
                    <li>Fax: <%= (OrderShippingAddress == null || OrderShippingAddress.Iscust_faxNull()) ? "" : OrderShippingAddress.cust_fax%></li>
                </ul>
                
                <!--Probably don't want this here: <%=( m_Order.IsCreditCardIdNull()) ? "Unknown" : m_Order.CreditCardInfoRow.CCType%> Card: <%=CreditCardLastFour %> -->

      
        </asp:WizardStep>
    </WizardSteps>
    <SideBarButtonStyle />
    <HeaderStyle HorizontalAlign="Left"  />
</asp:Wizard>

</div>

            <!-- Start of cart -->
            <div id="CheckOutCart">
            <asp:Repeater id="BillingCartRepeater" runat="server" EnableViewState="true">
                <HeaderTemplate>
                    <div>
                        </br>
                        <h2>Shopping Cart:</h2>
                        <table>
                            <thead>
                                <tr style="line-height:25px;">
                                    <td width="500"><b>Description</b></td>
                                    <td width="100" style="text-align:right;"><b>Quantity</b></td>
                                    <td width="140" style="text-align:right;"><b>Unit Price</b></td>
                                    <td width="140" style="text-align:right;"><b>Total Price</b></td>
                                    <td width="140" style="text-align:right;"><b>Weight</b></td>
                                </tr>
                                <tr style="background-color:#ccc; height:1px;"><td colspan="5"></td></tr>   
                            </thead>
                            <!-- tfoot should be declared after thead and before tbody -->
                            <tfoot>
                                <tr style="background-color:#ccc; height:1px;"><td colspan="5"></td></tr>   
                                <tr style="line-height:25px;">
                                    <td style="text-align:right;"><b>Merchandise Totals:</b></td>
                                    <td style="text-align:right;"><b><%=this.CartRow.ItemCount.ToString("N0") %></b></td>    
                                    <td>&nbsp;</td>
                                    <td style="text-align:right;" id="CartViewTotal">
                                        <b><%=this.CartRow.OrderSubTotal.ToString("C") %></b>
                                    </td>
                                    <td style="text-align:right;">
                                        <b><%=this.CartRow.WeightTotal.ToString("N0") %> lb</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="text-align:right">Sales Tax (<%=TaxPercent %>%):</td>
                                    <td style="text-align:right"><%=TaxCost.ToString("C") %></td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="text-align:right">
                                        Shipping Cost (<%=m_Order.IsShippingOptionNull()?"Choose Shipping":GetShippingOptionById(m_Order.ShippingOption).Name%>):
                                    </td>
                                    <td style="text-align:right">
                                        <%=m_Order.IsShippingOptionNull()?"":GetShippingOptionById(m_Order.ShippingOption).Cost.ToString("C")%>
                                    </td>
                                </tr>
                                <tr style="line-height:25px;">
                                    <td colspan="3" style="text-align:right"><b>Total:</b></td>
                                    <td style="text-align:right">
                                        <b><%=(this.CartRow.OrderSubTotal + ((m_Order.IsShippingOptionNull())?0:GetShippingOptionById(m_Order.ShippingOption).Cost)+TaxCost).ToString("C") %></b>
                                    </td>
                                </tr>
                            </tfoot>
                            <tbody>
                </HeaderTemplate>
                
                <ItemTemplate>
                                <tr>
                                    <td colspan="5" style="padding-top:5px;">
                                        <%# ((BusinessTier.DataAccessLayer.Cart.CartLineRow)((System.Data.DataRowView)Container.DataItem).Row).Description%> 
                                        <%# ((BusinessTier.DataAccessLayer.Cart.CartLineRow)((System.Data.DataRowView)Container.DataItem).Row).comment%>
                                    </td>
                                </tr>
                                <tr>
                                    <td> </td>
                                    <td style="text-align:right;">
                                        <input 
                                            type="hidden" 
                                            id="ProductId"
                                            value="<%#((BusinessTier.DataAccessLayer.Cart.CartLineRow)((System.Data.DataRowView)Container.DataItem).Row).ProdId%>"
                                            runat="server" 
                                        />
                                        <%#((BusinessTier.DataAccessLayer.Cart.CartLineRow)((System.Data.DataRowView)Container.DataItem).Row).Quantity.ToString("N0")%>
                                    </td>
                                    <td style="text-align:right;">
                                        <%#((BusinessTier.DataAccessLayer.Cart.CartLineRow)((System.Data.DataRowView)Container.DataItem).Row).Price.ToString("C")%>
                                    </td>
                                    <td style="text-align:right;">
                                        <%#(((BusinessTier.DataAccessLayer.Cart.CartLineRow)((System.Data.DataRowView)Container.DataItem).Row).Price * ((BusinessTier.DataAccessLayer.Cart.CartLineRow)((System.Data.DataRowView)Container.DataItem).Row).Quantity).ToString("C")%>
                                    </td>
                                    <td style="text-align:right;">
                                        <%#((BusinessTier.DataAccessLayer.Cart.CartLineRow)((System.Data.DataRowView)Container.DataItem).Row).Weight.ToString("N0") %> lb
                                    </td>
                                </tr>
                                <tr><td> &nbsp </td></tr>
                </ItemTemplate>

                <FooterTemplate>
                            </tbody>
                        </table>
                    </div>
                </FooterTemplate>
            </asp:Repeater>
            </div>
            <!-- END CART-->
            
            <div class="hints">
                <h2>Helpful Hints</h2>
                <ul>
                    <li>You are now in the checkout process.</li>
                    <li>First, you will be prompted to choose or enter your shipping address. Your shipping address will be saved so it can used as a billing address or for future orders.</li>
                    <li>Next, you will be presented with shipping options based on rates from our closest warehouse to your zip code.</li>
                    <li>Then, you will enter a billing address or choose an existing address; and enter credit card payment information which is transmitted to us via PayPal.</li>
                    <li>Last, you will see the order confirmation window - you must confirm your order at this step.</li>
                    <li>Please let us know if we can help you in any way.</li>
                </ul>

                <h2>Questions?</h2>
                <ul class="questions">
                    <li>We are ready to help.</li>
                    <li>Call us at 503.473.2878</li>
                </ul>

            </div>

</div>
</asp:Content>
