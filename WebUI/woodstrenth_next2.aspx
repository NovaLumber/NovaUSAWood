<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true"  CodeBehind="woodstrenth_next2.aspx.cs" Inherits="WebUI.woodstrenth_next2" %>
<%@ Import Namespace="System.Data" %> 
<%@ Import Namespace="BusinessTier.DataAccessLayer" %> 

<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content99" ContentPlaceHolderID="Header" runat="server">
    <style>

            .link-text{
                font-family: 'Verdana';
                font-weight: 100;
                font-size: small;
                padding-left: 10px;
                white-space:nowrap;
            }

        div.progress-bar {
            background-image:none; 
            background-color:tan; 
            text-align:left;
            white-space:nowrap !important; 
        }

    </style>
    <script type="text/javascript">

        function toInteger(number) {
            return Math.round(  // round to nearest integer
                Number(number)    // type cast your input
            );
        };

        $(document).ready(function () {

            var progressBars = document.querySelectorAll(".progress-bar");
            var i = 0;

            sequenced_animate();

            function sequenced_animate() {

                if (i >= progressBars.length)
                    return;

                // Get the element and the ID.
                var elem = progressBars[i];
                var selector = '#' + elem.getAttribute("id");
                var targetPercentageValue = toInteger(elem.getAttribute("data-value") / 1000) + 30;
                var width = targetPercentageValue + "%";

                $(selector).animate({ "width": width }, 100, function () { i += 1; sequenced_animate();});

            }
         });

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
                    string href = "<a href=" + '"' + link + '"' + "class=" + '"' + "link-text" + '"' + ">" + linkText + "</a>";
            %>

        <div class="progress" style="width:100%;">
            <div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" id="<%= row["FilterEntry_id"] %>" data-value="<%= row["mor"].ToString()%>">
                <span class="link-text"><%=linkText%></span>
            </div>
        </div>

           
                <%
        }
%>            
        
    <p><sup>(1)</sup> The Wood Handbook - Wood as an engineering material, USDA, General Technical Report 113.</p>
    </div> <!-- end strength-page -->
<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->

</asp:Content>

