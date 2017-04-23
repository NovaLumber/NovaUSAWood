<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="WebUI.about" Title="Untitled Page" %>
<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
<div id="mainWithSideBar">

<h1>About Nova</h1>
<p>Nova is committed to providing the best products, service and value possible in its hardwood programs by combining its own agile and efficient operational infrastructure with a large network of leading South American and Asian manufacturers.</p>

<p>With offices in Northern and Southern Brazil, and in Indonesia, Nova offers the very best in quality control, logistics, product knowledge and supplier relationships. Nova also works with the leading manufacturers in South America and Asia to give our customers superior, top-quality products at the most competitive prices available.</p>

<p>Our US import division was started in 2005 and now includes warehouse locations in Tilton, NH, San Carlos, CA and Bellmawr, NJ. Our US headquarters are in Portland, OR where we manage finance and accounting, information technology and Western US sales. Our Northeast sales office and warehouse is in Tilton, NH.</p>

<h2>Our Pledge To You</h2>
<ul class="bullets">
    <li>We develop long-term partnerships with our customers and suppliers.</li>
    <li>We follow through on our commitments.</li>
    <li>We strive to be the best we can be, constantly working to improve.</li>
    <li>We treat our business partners with respect.</li>
</ul> 

<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->
</asp:Content>    