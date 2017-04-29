<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="woodstrength_next.aspx.cs" Inherits="WebUI.woodstrength_next" Title="Nova - Wood Strength"%>
<%@ Import Namespace="System.Data" %> 
<%@ Import Namespace="BusinessTier.DataAccessLayer" %> 

<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content99" ContentPlaceHolderID="Header" runat="server">
    <style>

        progress {
            width:80%;
            border-radius: 3px;
            background-color:ghostwhite;     
            color: tan;
            height: 20px;
            margin-bottom: 10px;
        }
    </style>
    <script type="text/javascript">

        function toInteger(number) {
            return Math.round(  // round to nearest integer
                Number(number)    // type cast your input
            );
        };

        function animate(elem, percentage)
        {
            var interval = 1;
            var updatesPerSecond = 1000 / 60;
            var max = 100;

            if (!elem) {
                // alert("Elem is null!");
                return;
            }
            var val = toInteger(elem.getAttribute("value"));

            if (val < percentage) {
                val = val + interval;
                elem.setAttribute("value", val);
                setTimeout(animate, updatesPerSecond, elem, percentage);
            } else {
                setTimeout(animate, 5000);
            }

        }

        $(document).ready(function () {

            // Grab each progress bar and update it.

            var updatesPerSecond = 2000;

            var items = document.querySelectorAll("progress");

            for (var i = 0; i < items.length; i++)
            {
                var item = items[i];
                var percentage = toInteger(item.getAttribute("data-value") / 1000);
                
                animate(item, percentage);
                window.setInterval(function () {
                    console.log("Interval set called.");
                }, 1000);
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
                
            %>

                <div>
                <progress id="<%= row["FilterEntry_id"] %>" max="100" data-value="<%= row["mor"].ToString()%>" value="0"></progress>
</div>
<%--            
                <div id="<%= row["FilterEntry_id"] %>" class="progress" data-value="<%= row["mor"].ToString() %>">  
                    <span><a href="<%= link %>"><%= linkText  %></a></span>
                </div>--%>
                
           
                <%
        }
%>            
        
    <p><sup>(1)</sup> The Wood Handbook - Wood as an engineering material, USDA, General Technical Report 113.</p>
    </div> <!-- end strength-page -->
<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->

</asp:Content>

