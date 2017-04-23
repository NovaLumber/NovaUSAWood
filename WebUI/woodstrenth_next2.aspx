<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="woodstrenth_next2.aspx.cs" Inherits="WebUI.woodstrenth_next2" %>

<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Progressbar - Default functionality</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>

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

      function toInteger(number)
      {
          return Math.round(Number(number));
      }

      $(function(){

          //=== For each MOR div.

          $(".progressBar").each(function (i, n) {

              //=== Get the ID and the MOR value.

              var idSelector = "#" + n.getAttribute("id");
              var dataValue = n.getAttribute("data-value");
              var percentageDataValue = toInteger(n.getAttribute("data-value") / 1000);  // To derive a percentage.

              //=== Now, create a progress bar on that div and animate the fill up to the value..

              $(idSelector).progressbar({ value: 1 });
              $(idSelector).animate_progressbar(percentageDataValue, 1000);

          });
      })
  </script>
</head>
<body>
 
<%

        BusinessTier.DataAccessLayer.DataAccessLayer dl = new DataAccessLayer();
        int isWood = 1;

        System.Data.DataTable dt =     dl.GetSpeciesMOR(isWood);

        foreach(System.Data.DataRow row in dt.Rows)
        {


    %>

        <div style="margin-top:10px">
        <div id="<%= row["prod_id"] %>" class="progressBar" data-value="<%= row["mor"].ToString() %>" />
           </div>
    <%
        }
%>
 
</body>
</html>