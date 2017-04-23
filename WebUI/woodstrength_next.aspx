<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage.Master" AutoEventWireup="true" CodeBehind="woodstrength_next.aspx.cs" Inherits="WebUI.woodstrength_next" Title="Nova - Wood Strength"%>
<%@ Import Namespace="System.Data" %> 
<%@ Import Namespace="BusinessTier.DataAccessLayer" %> 

<asp:Content ID="SideMenuPlaceHolder1" ContentPlaceHolderID="SideMenuPlaceHolder" runat="server">
    <ui:SubNavigationBar id="SubNavigationBar1" runat="server" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Header" runat="server">

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script> 
    <script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script type="text/javascript" language="javascript">
    (function ($) {
        $.fn.animate_progressbar = function (value, duration, easing, complete) {
            if (value == null) value = 0;
            if (duration == null) duration = 1000;
            if (easing == null) easing = 'swing';
            if (complete == null) complete = function () { };
            var progress = this.find('.ui-progressbar-value');
            progress.stop(true).animate({
                width: value + '%'
            }, duration, easing, function () {
                if (value >= 99.5) {
                    progress.addClass('ui-corner-right');
                } else {
                    progress.removeClass('ui-corner-right');
                }
                complete();
            });
        }
    })(jQuery);

    function toInteger(number) {
        return Math.round(Number(number));
    }

        //$(document.ready(function () {

        //    //=== For each MOR div.

        //    $(".progress").each(function (i, n) {

        //        //=== Get the ID and the MOR value.

        //        var idSelector = "#" + n.getAttribute("id");
        //        var dataValue = n.getAttribute("data-value");
        //        var percentageDataValue = toInteger(n.getAttribute("data-value") / 1000);  // To derive a percentage.

        //        //=== Now, create a progress bar on that div and animate the fill up to the value..

        //        //this.progressbar({ value: 1 });
        //        //this.animate_progressbar(percentageDataValue, 1000);

        //        //$(idSelector).progressbar({ value: 1 });
        //        $(idSelector).progressbar({ value: 1 }).children("span").appendTo(this);
        //        $(idSelector).animate_progressbar(percentageDataValue, 1000);

        //});

    $(function () {

        //=== For each MOR div.

        $(".progress").each(function (i, n) {

            //=== Get the ID and the MOR value.

            var idSelector = "#" + n.getAttribute("id");
            var dataValue = n.getAttribute("data-value");
            var percentageDataValue = toInteger(n.getAttribute("data-value") / 1000);  // To derive a percentage.

            //=== Now, create a progress bar on that div and animate the fill up to the value..

            //this.progressbar({ value: 1 });
            //this.animate_progressbar(percentageDataValue, 1000);

            //$(idSelector).progressbar({ value: 1 });
            $(idSelector).progressbar({ value: 1 }).children("span").appendTo(this);
            $(idSelector).animate_progressbar(percentageDataValue, 5000);

        });
    })
</script>
<style type="text/css">

    .progress{margin-bottom: 10px;}
    .progress[aria-valuenow="0"] span {margin-bottom:30px;}
    .progress.ui-progressbar {position:relative;height:2em;}
    .progress span {position:static;margin-top:-2em;text-align:left;display:block;line-height:2em;padding-left:10px;padding-right:10px;}

    /*.progressBarLabel {
    position: absolute;
    width: 100%;
    float: left;
    line-height: 200%;
}

    .progressBar {
    width: 80%;
    text-align: center;
    margin-top:10px;*/
}
</style>
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

            
                <div id="<%= row["FilterEntry_id"] %>" class="progress" data-value="<%= row["mor"].ToString() %>">  
                    <span><a href="<%= link %>"><%= linkText  %></a></span>
                </div>
                
           
                <%
        }
%>


<%--            <asp:Repeater ID="SpecieRepeater" runat="server">
                <ItemTemplate>
                    <li>
                    <div style="width:<%#(((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).mor/47+100).ToString("N0") %>px;" class="chartBar">
                        <a href="products.aspx?FilterstoAdd=<%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).FilterEntry_id.ToString("N0")%>" class="chartLink" >
                        <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).species_description.ToString() %>
                        <%#((BusinessTier.DataAccessLayer.Species.speciesRow)Container.DataItem).mor.ToString("N0") %> psi
                        </a>
                    </div>
                    </li>
                </ItemTemplate>
            </asp:Repeater>--%>
            
        
    <p><sup>(1)</sup> The Wood Handbook - Wood as an engineering material, USDA, General Technical Report 113.</p>
    </div> <!-- end strength-page -->
<div class="clearfix"></div>
</div><!-- end mainWithSideBar -->

</asp:Content>

