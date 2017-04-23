<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/FullScreen.Master" AutoEventWireup="true" CodeBehind="gallery-single.aspx.cs" 
    Inherits="WebUI.gallery_single" Title="Nova USA - Photo Viewer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<script language="javascript" type="text/javascript">
    function Back()
    {
        history.go(-1);
        return false;
    }
</script>

<img alt="" src="/images/scenes/<% Response.Write(Request.QueryString["photo"]); %>" />

<p><input type="submit" name="btnEdit" value="Back" onclick="return Back();" id="btnEdit" class="buttonstyle" />
</p>

</asp:Content>
