<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="woodstrength_next.aspx.cs" Inherits="WebUI.woodstrength_next" Title="Nova - Wood Strength"%>
<%@ Import Namespace="System.Data" %> 
<%@ Import Namespace="BusinessTier.DataAccessLayer" %> 

<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content99" ContentPlaceHolderID="Header" runat="server">
    <style>
            .progressBarLinkText{
                font-family:'Verdana';
                font-size: small;
            }

            .progressBarContainer {
                width: 80%;
                border-radius:3px;
                background-color: ghostwhite;
            }
                      
            .progressBar {
                width: 1%;
                height: 30px;
                line-height: 30px;
                border-radius:3px;
                background-color: tan;
                white-space:nowrap;
                margin-bottom: 10px;
            }

    </style>
    <script type="text/javascript">

        function toInteger(number) {
            return Math.round(  // round to nearest integer
                Number(number)    // type cast your input
            );
        };

        $(document).ready(function () {

            var progressBars = document.querySelectorAll(".progressBar");

            $(".progressBar").each(function (index, elem) {

                // Set the data-percent-target attribute to the target percentage.

                var targetValue = (elem.getAttribute("data-value") / 1000);
                var speed = 16;
                var increment = 1;

                animateProgressBar(elem, targetValue, increment, speed);

            });

        });

        function animateProgressBar(elem, targetValue, increment, speed)
        {
            // Get the width of the containing div.

            var width = 1;
            var id = setInterval(frame, speed);

            function frame()
            {
                var currentValue = toInteger(elem.getAttribute("data-percent-target"));

                if (currentValue < targetValue) {
                    currentValue = currentValue + increment;
                    elem.setAttribute("data-percent-target", currentValue++);
                    width++;
                    elem.style.width = width + '%';
                }
                else {
                    // THIS IS  HACK TO MOVE THE PROGRESS BAR FURTHER ALONG SOLELY FOR EFFECT.

                    clearInterval(id);
                }
            }
        }
        
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    
<div id="mainWithSideBar">
    <div id="strength-page">
    <h1>Modulus of Rupture (MOR) Ratings for Various Species of Wood (psi)</h1>
    <p>The modulus of rupture is a measure of the maximum load carrying capacity of a given species in bending strength and is proportional to the breaking point or maximum strength as borne by the specimen.<sup>(1)</sup></p>
            <% 

                // Get the data from the database.

                BusinessTier.DataAccessLayer.DataAccessLayer dl = new DataAccessLayer();
                int isWood = 1;

                System.Data.DataTable dt =     dl.GetSpeciesMOR(isWood);

                foreach(System.Data.DataRow row in dt.Rows)
                {

                    string link = "products.aspx?FiltersToAdd=" + row["FilterEntry_id"].ToString();
                    string linkText = row["species_description"].ToString() + " " + row["mor"].ToString() + " psi";
                    string href = "<a href=" + '"' + link + '"' + ">" + linkText + "</a>";
            %>
        <div class="progressBarContainer">
            <div class="progressBar" id="<%= row["FilterEntry_id"] %>" data-value="<%= row["mor"].ToString()%>" data-percent-target="0"><span class="progressBarLinkText" style="padding-left: 15px"><%=href%></span></div>
        </div>
           
                <%
        }
%>            
        
    <p><sup>(1)</sup> The Wood Handbook - Wood as an engineering material, USDA, General Technical Report 113.</p>
    </div> <!-- end strength-page -->
<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->

</asp:Content>

