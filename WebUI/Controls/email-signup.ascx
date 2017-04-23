<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="email-signup.ascx.cs" Inherits="WebUI.Controls.email_signup" %>

    <p>Join our email list to connect with us...<br />
    email <asp:TextBox width="210px" runat="server" ID="email"/> 
    zip code <asp:TextBox width="100px" runat="server" ID="zipcode"/>
    &nbsp interested in: <asp:CheckBox runat="server" ID="decking" />decking 
    <asp:CheckBox runat="server" ID="flooring" />flooring
    <asp:CheckBox runat="server" ID="kilnsticks" />kiln sticks
    <asp:CheckBox runat="server" ID="truckflooring" />truck flooring
    &nbsp <asp:Button ID="Signup" OnClick="SignUp_Click" runat="server" Text="Sign Up" />
    </p>
    