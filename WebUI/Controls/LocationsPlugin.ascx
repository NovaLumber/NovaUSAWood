<%@ Control Language="C#" AutoEventWireup="True" CodeBehind ="LocationsPlugin.ascx.cs" Inherits="WebUI.Controls.LocationsPlugin" %>

<asp:Repeater ID="locationSelect" runat="server">
<HeaderTemplate>
<select name="locationSelect" onchange="formHandler(this)" >
</HeaderTemplate>
<ItemTemplate>
        <option value="~/Locations.aspx#<%#((BusinessTier.DataAccessLayer.Locations.LocationRow)((System.Data.DataRowView)Container.DataItem).Row).LocationId %> ">
        <%#((BusinessTier.DataAccessLayer.Locations.LocationRow)((System.Data.DataRowView)Container.DataItem).Row).City%>,
         <%#((BusinessTier.DataAccessLayer.Locations.LocationRow)((System.Data.DataRowView)Container.DataItem).Row).State%></option>
</ItemTemplate>
<FooterTemplate>
</select>
</FooterTemplate>
</asp:Repeater>