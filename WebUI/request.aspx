<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="request.aspx.cs" Inherits="WebUI.request" Title="Untitled Page" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server"><div id="mainWithSideBar">

<div class="bodyText_noBanner">

    <form id="request_form" runat="server">

        <h2>Request Information</h2> 

        <table>
            <tr>
                <td>
                    Email Address: 
                </td>
                <td>
                    <asp:TextBox runat="server" ID="email" text="" width="25em" TextMode="SingleLine" />
                </td>
            </tr>
            <tr>
                <td>
                    Name: 
                </td>
                <td>
                    <asp:TextBox runat="server" ID="name" text="" width="25em" TextMode="SingleLine" />
                </td>
            </tr>
            <tr>
                <td>
                    Address: 
                </td>
                <td>
                    <asp:TextBox runat="server" ID="address" text="" width="25em" TextMode="SingleLine" />
                </td>
            </tr>
            <tr>
                <td>
                    City State Zip: 
                </td>
                <td>
                    <asp:TextBox runat="server" ID="city" text="" width="14.8em" TextMode="SingleLine" />
                    <asp:TextBox runat="server" ID="state" text="" width="3em" TextMode="SingleLine" />
                    <asp:TextBox runat="server" ID="zip" text="" width="6em" TextMode="SingleLine" />
                </td>
            </tr>
            <tr>
                <td>
                    Message: 
                </td>
                <td>
                    <asp:TextBox runat="server" ID="message" text="" width="25em" Height="8em" TextMode="MultiLine" />
                </td>
            </tr>
            
        </table>
        
        <asp:Button width="80" runat="server" ID="submit" OnClick="submit_Click" Text="Submit" />

    </form>

</div>


<div class="clearfix"></div></div><!-- end mainWithSideBar --></asp:Content>  