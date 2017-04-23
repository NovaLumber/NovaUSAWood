<%@ Page EnableViewState="false" EnableSessionState="ReadOnly" Language="C#" MasterPageFile="~/UiMasterPage-Plain.Master" AutoEventWireup="true" CodeBehind="color-design-tool.aspx.cs" Inherits="WebUI.color_design_tool" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">


<div id="designer">

    <h1>Color Palette Design Tool</h1>

    <div id="accent-horizontal" class="accent">    
        <a href="#"><img alt="accent horizontal" id="accent-horizontal-img" src="images/designer/accent-hz-blank.gif" rel="#accent-selector"/></a>
    </div>
    
    <div id="accent-vertical" class="accent">    
        <a href="#"><img alt="accent vertical" id="accent-vertical-img" src="images/designer/accent-vt-blank.gif" rel="#accent-selector"/></a>
    </div>    

    <div id="paint2">    
        <a href="#"><img alt="paint2" id="paint2-img" src="images/designer/paint2-blank.gif" rel="#paint2-selector"/></a>
    </div>

    <div id="paint1">    
        <a href="#"><img alt="paint1" id="paint1-img" src="images/designer/paint1-blank.gif" rel="#paint1-selector"/></a>
    </div>

    <div id="counter">    
        <a href="#"><img alt="counters" id="counter-img" src="images/designer/counter-blank.gif" rel="#counter-selector"/></a>
    </div>

    <div id="cabinet">    
        <a href="#"><img alt="cabinets" id="cabinet-img" src="images/designer/cabinet-blank.gif" rel="#cabinet-selector"/></a>
    </div>

    <div id="molding">    
        <a href="#"><img alt="molding" id="molding-img" src="images/designer/molding-blank.gif" rel="#molding-selector"/></a>
    </div>

    <div id="flooring">          
        <!--
        <div id="tile">
            <a href="#"><img alt="tile" id="tile-img" src="images/designer/tile-blank.gif" rel="#tile-selector"/></a>
        </div>
        -->
        
        <a href="#"><img alt="hardwood flooring" id="flooring-img" src="images/designer/floor-blank.gif" rel="#flooring-selector"/></a>

    </div>  
    
    <div id="legend">
        <p>
            <span id="legend-paint1">Legend - </span>
            <span id="legend-paint2"></span>
            <span id="legend-accent"></span>
        </p>
        <p>
            <span id="legend-counter"></span>
            <span id="legend-cabinet"></span>
            <span id="legend-molding"></span>
            <span id="legend-tile"></span>
            <span id="legend-flooring"></span>
        </p>
        <p style="color:White; visibility:hidden; height:0px;">
            <span id="paint1-code"></span><span id="paint1-desc"></span>
            <span id="paint2-code"></span><span id="paint2-desc"></span>
            <span id="accent-code"></span><span id="accent-desc"></span>
            <span id="counter-file"></span><span id="counter-desc"></span>
            <span id="cabinet-file"></span><span id="cabinet-desc"></span>
            <span id="molding-file"></span><span id="molding-desc"></span>
            <span id="flooring-file"></span><span id="flooring-desc"></span>
        </p>
    </div>
    
    <div id="designer-choices">
        <input value="Design 1" type="button" onclick="design1();" />
        <input value="Design 2" type="button" onclick="design2();" />
        <input value="Design 3" type="button" onclick="design3();" />
        <input value="Save My Design" type="button" onclick="savedesign();" />
        <input value="Load Saved Design" type="button" onclick="loadlastdesign();" />
    </div>
    
    <div id="footer">
        <p>Copyright 2010, Elemental Flooring by Nova</p>
        <asp:Label ID="Label1" runat="server"></asp:Label>
    </div>

</div>


<div id="dhtmltooltip"></div>

<script type="text/javascript">

/***********************************************
* Cool DHTML tooltip script- © Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/

var offsetxpoint=-60 //Customize x offset of tooltip
var offsetypoint=20 //Customize y offset of tooltip
var ie=document.all
var ns6=document.getElementById && !document.all
var enabletip=false
if (ie||ns6)
var tipobj=document.all? document.all["dhtmltooltip"] : document.getElementById? document.getElementById("dhtmltooltip") : ""

function ietruebody(){
return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body
}

function ddrivetip(thetext, thecolor, thewidth){
if (ns6||ie){
if (typeof thewidth!="undefined") tipobj.style.width=thewidth+"px"
if (typeof thecolor!="undefined" && thecolor!="") tipobj.style.backgroundColor=thecolor
tipobj.innerHTML=thetext
enabletip=true
return false
}
}

function positiontip(e){
if (enabletip){
var curX=(ns6)?e.pageX : event.clientX+ietruebody().scrollLeft;
var curY=(ns6)?e.pageY : event.clientY+ietruebody().scrollTop;
//Find out how close the mouse is to the corner of the window
var rightedge=ie&&!window.opera? ietruebody().clientWidth-event.clientX-offsetxpoint : window.innerWidth-e.clientX-offsetxpoint-20
var bottomedge=ie&&!window.opera? ietruebody().clientHeight-event.clientY-offsetypoint : window.innerHeight-e.clientY-offsetypoint-20

var leftedge=(offsetxpoint<0)? offsetxpoint*(-1) : -1000

//if the horizontal distance isn't enough to accomodate the width of the context menu
if (rightedge<tipobj.offsetWidth)
//move the horizontal position of the menu to the left by it's width
tipobj.style.left=ie? ietruebody().scrollLeft+event.clientX-tipobj.offsetWidth+"px" : window.pageXOffset+e.clientX-tipobj.offsetWidth+"px"
else if (curX<leftedge)
tipobj.style.left="5px"
else
//position the horizontal position of the menu where the mouse is positioned
tipobj.style.left=curX+offsetxpoint+"px"

//same concept with the vertical position
if (bottomedge<tipobj.offsetHeight)
tipobj.style.top=ie? ietruebody().scrollTop+event.clientY-tipobj.offsetHeight-offsetypoint+"px" : window.pageYOffset+e.clientY-tipobj.offsetHeight-offsetypoint+"px"
else
tipobj.style.top=curY+offsetypoint+"px"
tipobj.style.visibility="visible"
}
}

function hideddrivetip(){
if (ns6||ie){
enabletip=false
tipobj.style.visibility="hidden"
tipobj.style.left="-1000px"
tipobj.style.backgroundColor=''
tipobj.style.width=''
}
}

document.onmousemove=positiontip

</script>


<div class="simple_overlay" id="flooring-selector"> 
    <div id="flooringTypes">
        <h2>Flooring Options</h2>
        <div id="floor1" class="clickers" onmouseover="ddrivetip('Acacia Natural','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="floor2" class="clickers" onmouseover="ddrivetip('Acacia Rosewood','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="floor3" class="clickers" onmouseover="ddrivetip('Amendoim','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="floor4" class="clickers" onmouseover="ddrivetip('Birch Natural','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="floor5" class="clickers" onmouseover="ddrivetip('Brazilian Cherry','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="floor6" class="clickers" onmouseover="ddrivetip('Cumaru','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="floor7" class="clickers" onmouseover="ddrivetip('Ipe, Brazilian Walnut','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="floor8" class="clickers" onmouseover="ddrivetip('Kurupayra, Angico','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="floor9" class="clickers" onmouseover="ddrivetip('Lapacho Ipe','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="floor10" class="clickers" onmouseover="ddrivetip('Brazilian Redwood, Massaranduba','#eee')"; onmouseout="hideddrivetip()"></div>
    </div>
    <div style="clear:both;">
        <div id="floor11" class="clickers" onmouseover="ddrivetip('Para Rosewood','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="floor12" class="clickers" onmouseover="ddrivetip('Patagonian Rosewood, Curupau','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="floor13" class="clickers" onmouseover="ddrivetip('Red Oak Natural','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="floor14" class="clickers" onmouseover="ddrivetip('Canarywood, Tarara','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="floor15" class="clickers" onmouseover="ddrivetip('Tiete Rosewood, Sirari','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="floor16" class="clickers" onmouseover="ddrivetip('Tigerwood','#eee')"; onmouseout="hideddrivetip()"></div>
    </div>
</div>

<div class="simple_overlay" id="counter-selector"> 
    <div id="counterTypes">
        <h2>Counter Options</h2>
        <div id="counter1" class="clickers" onmouseover="ddrivetip('Black Galaxy','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="counter2" class="clickers" onmouseover="ddrivetip('Cambrian Black','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="counter3" class="clickers" onmouseover="ddrivetip('Bianco Sardo Flamed','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="counter4" class="clickers" onmouseover="ddrivetip('Blue Pearl','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="counter5" class="clickers" onmouseover="ddrivetip('Gialo Veneziano','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="counter6" class="clickers" onmouseover="ddrivetip('Red Multi Color','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="counter7" class="clickers" onmouseover="ddrivetip('Silver Pearl','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="counter8" class="clickers" onmouseover="ddrivetip('Tan Brown','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="counter9" class="clickers" onmouseover="ddrivetip('Ubatuba','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="counter10" class="clickers" onmouseover="ddrivetip('Verde Crystal','#eee')"; onmouseout="hideddrivetip()"></div>
    </div>
</div>

<div class="simple_overlay" id="cabinet-selector"> 
    <div id="cabinetTypes">
        <h2>Cabinet Options</h2>
        <div id="cabinet1" class="clickers" onmouseover="ddrivetip('Red Oak','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="cabinet2" class="clickers" onmouseover="ddrivetip('Maple','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="cabinet3" class="clickers" onmouseover="ddrivetip('Walnut','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="cabinet4" class="clickers" onmouseover="ddrivetip('Douglas Fir','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="cabinet5" class="clickers" onmouseover="ddrivetip('Cherry','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="cabinet6" class="clickers" onmouseover="ddrivetip('White','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="cabinet7" class="clickers" onmouseover="ddrivetip('Almond','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="cabinet8" class="clickers" onmouseover="ddrivetip('Knotty Pine','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="cabinet9" class="clickers" onmouseover="ddrivetip('White Oak','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="cabinet10" class="clickers" onmouseover="ddrivetip('White Oak Tuscany','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="cabinet11" class="clickers" onmouseover="ddrivetip('Spruce','#eee')"; onmouseout="hideddrivetip()"></div>
    </div>
</div>

<div class="simple_overlay" id="molding-selector"> 
    <div id="moldingTypes">
        <h2>Molding Options</h2>
        <div id="molding1" class="clickers" onmouseover="ddrivetip('White','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="molding2" class="clickers" onmouseover="ddrivetip('Almond','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="molding3" class="clickers" onmouseover="ddrivetip('Red Oak','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="molding4" class="clickers" onmouseover="ddrivetip('Maple','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="molding5" class="clickers" onmouseover="ddrivetip('Cherry','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="molding6" class="clickers" onmouseover="ddrivetip('Mahogany','#eee')"; onmouseout="hideddrivetip()"></div>
        <div id="molding7" class="clickers" onmouseover="ddrivetip('Douglas Fir','#eee')"; onmouseout="hideddrivetip()"></div>
    </div>
</div>

<div class="simple_overlay" id="tile-selector"> 
    <div id="tileTypes">
        <h2>Tile Options</h2>
        <div id="tile1" class="clickers"></div>
        <div id="tile2" class="clickers"></div>
    </div>
</div>

<div class="simple_overlay" style="max-height:519px; overflow:scroll;" id="accent-selector"> 
    <div id="accentColors">
        <h2>Accent Color Options</h2>
        <div>
            <h2>Espresso Blends</h2>
            <div id="accent1" class="clickers" onmouseover="ddrivetip('Sumatra','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent2" class="clickers" onmouseover="ddrivetip('Mocha','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent3" class="clickers" onmouseover="ddrivetip('Steamer','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent4" class="clickers" onmouseover="ddrivetip('Roast','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent5" class="clickers" onmouseover="ddrivetip('Hazelnut','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent6" class="clickers" onmouseover="ddrivetip('Cappuccino','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent7" class="clickers" onmouseover="ddrivetip('Bavarian','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent8" class="clickers" onmouseover="ddrivetip('Green','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent9" class="clickers" onmouseover="ddrivetip('Cocoa','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent10" class="clickers" onmouseover="ddrivetip('Medallion','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>
        <div style="clear:both;">
            <h2>Natural Blondes</h2>
            <div id="accent11" class="clickers" onmouseover="ddrivetip('Butter','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent12" class="clickers" onmouseover="ddrivetip('Maple','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent13" class="clickers" onmouseover="ddrivetip('Honey','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent14" class="clickers" onmouseover="ddrivetip('Bamboo','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent15" class="clickers" onmouseover="ddrivetip('Manilla','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent16" class="clickers" onmouseover="ddrivetip('Teak','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent17" class="clickers" onmouseover="ddrivetip('Oak','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent18" class="clickers" onmouseover="ddrivetip('Straw','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent19" class="clickers" onmouseover="ddrivetip('Ale','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent20" class="clickers" onmouseover="ddrivetip('Gold','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent21" class="clickers" onmouseover="ddrivetip('Birch','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent22" class="clickers" onmouseover="ddrivetip('Cream','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>        
        <div style="clear:both;">
            <h2>Cool Grasses & Evergreens</h2>
            <div id="accent23" class="clickers" onmouseover="ddrivetip('Hosta','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent24" class="clickers" onmouseover="ddrivetip('Moss','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent25" class="clickers" onmouseover="ddrivetip('Cypress','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent26" class="clickers" onmouseover="ddrivetip('Spruce','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent27" class="clickers" onmouseover="ddrivetip('Fir','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent28" class="clickers" onmouseover="ddrivetip('Juniper','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent29" class="clickers" onmouseover="ddrivetip('Pine','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent30" class="clickers" onmouseover="ddrivetip('Blade','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent31" class="clickers" onmouseover="ddrivetip('Fescue','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent32" class="clickers" onmouseover="ddrivetip('Manzanita','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>        
        <div style="clear:both;">
            <h2>Valley Vineyards & Spice</h2>
            <div id="accent33" class="clickers" onmouseover="ddrivetip('Cayenne','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent34" class="clickers" onmouseover="ddrivetip('Ginger','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent35" class="clickers" onmouseover="ddrivetip('Spice','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent36" class="clickers" onmouseover="ddrivetip('Paprika','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent37" class="clickers" onmouseover="ddrivetip('Cabernet','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent38" class="clickers" onmouseover="ddrivetip('Bordeaux','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent39" class="clickers" onmouseover="ddrivetip('Pinot','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent40" class="clickers" onmouseover="ddrivetip('Merlot','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent41" class="clickers" onmouseover="ddrivetip('Shiraz','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent42" class="clickers" onmouseover="ddrivetip('Sangria','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent43" class="clickers" onmouseover="ddrivetip('Saffron','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent44" class="clickers" onmouseover="ddrivetip('Blush','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>        
        <div style="clear:both;">
            <h2>Silver Skies</h2>
            <div id="accent45" class="clickers" onmouseover="ddrivetip('Twilight','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent46" class="clickers" onmouseover="ddrivetip('Tempest','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent47" class="clickers" onmouseover="ddrivetip('Thunder','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent48" class="clickers" onmouseover="ddrivetip('Dusk','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent49" class="clickers" onmouseover="ddrivetip('Mist','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent50" class="clickers" onmouseover="ddrivetip('Fog','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent51" class="clickers" onmouseover="ddrivetip('Rain','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent52" class="clickers" onmouseover="ddrivetip('Storm','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent53" class="clickers" onmouseover="ddrivetip('Frost','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent54" class="clickers" onmouseover="ddrivetip('Wind','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent55" class="clickers" onmouseover="ddrivetip('Silver','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent56" class="clickers" onmouseover="ddrivetip('Skyline','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>  
        <div style="clear:both;">
            <h2>Ocean Tidepools</h2>
            <div id="accent57" class="clickers" onmouseover="ddrivetip('Blue','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent58" class="clickers" onmouseover="ddrivetip('Reef','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent59" class="clickers" onmouseover="ddrivetip('Breeze','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent60" class="clickers" onmouseover="ddrivetip('Reflection','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent61" class="clickers" onmouseover="ddrivetip('Foam','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent62" class="clickers" onmouseover="ddrivetip('Coast','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent63" class="clickers" onmouseover="ddrivetip('Cool','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent64" class="clickers" onmouseover="ddrivetip('Tide','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent65" class="clickers" onmouseover="ddrivetip('Swell','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent66" class="clickers" onmouseover="ddrivetip('Pool','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent67" class="clickers" onmouseover="ddrivetip('Current','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent68" class="clickers" onmouseover="ddrivetip('Spray','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>                                              
        <div style="clear:both;">
            <h2>Sweet & Hot Beans</h2>
            <div id="accent69" class="clickers" onmouseover="ddrivetip('Bananas & Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent70" class="clickers" onmouseover="ddrivetip('Kiwis & Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent71" class="clickers" onmouseover="ddrivetip('Full o Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent72" class="clickers" onmouseover="ddrivetip('Peaches & Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent73" class="clickers" onmouseover="ddrivetip('Mango Tango Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent74" class="clickers" onmouseover="ddrivetip('Passion Fashion Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent75" class="clickers" onmouseover="ddrivetip('Black & Blue Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent76" class="clickers" onmouseover="ddrivetip('Lemon Drop Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent77" class="clickers" onmouseover="ddrivetip('Pistachio Lime Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent78" class="clickers" onmouseover="ddrivetip('Berry Chili Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent79" class="clickers" onmouseover="ddrivetip('Berries & Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent80" class="clickers" onmouseover="ddrivetip('Grapes & Beans','#eee')"; onmouseout="hideddrivetip()"></div>
        </div> 
        <div style="clear:both;">
            <h2>Pebbles & Creams</h2>
            <div id="accent81" class="clickers" onmouseover="ddrivetip('Ash','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent82" class="clickers" onmouseover="ddrivetip('Feather','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent83" class="clickers" onmouseover="ddrivetip('Stone','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent84" class="clickers" onmouseover="ddrivetip('Pebble','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent85" class="clickers" onmouseover="ddrivetip('Whip','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent86" class="clickers" onmouseover="ddrivetip('Sand','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent87" class="clickers" onmouseover="ddrivetip('Custard','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent88" class="clickers" onmouseover="ddrivetip('Glass','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent89" class="clickers" onmouseover="ddrivetip('Shell','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent90" class="clickers" onmouseover="ddrivetip('Grain','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent91" class="clickers" onmouseover="ddrivetip('Vanilla','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent92" class="clickers" onmouseover="ddrivetip('Icing','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>                                
        <div style="clear:both;">
            <h2>Pacific Trail Mix</h2>
            <div id="accent93" class="clickers" onmouseover="ddrivetip('Crunch','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent94" class="clickers" onmouseover="ddrivetip('Olive','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent95" class="clickers" onmouseover="ddrivetip('Cashew','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent96" class="clickers" onmouseover="ddrivetip('Date','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent97" class="clickers" onmouseover="ddrivetip('Almond','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent98" class="clickers" onmouseover="ddrivetip('Pecan','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent99" class="clickers" onmouseover="ddrivetip('Macadamia','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent100" class="clickers" onmouseover="ddrivetip('Peanut','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent101" class="clickers" onmouseover="ddrivetip('Filbert','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent102" class="clickers" onmouseover="ddrivetip('Oat','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent103" class="clickers" onmouseover="ddrivetip('Ginseng','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>                                
        <div style="clear:both;">
            <h2>Desert Lights</h2>
            <div id="accent104" class="clickers" onmouseover="ddrivetip('Mesa','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent105" class="clickers" onmouseover="ddrivetip('Brick','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent106" class="clickers" onmouseover="ddrivetip('Glow','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent107" class="clickers" onmouseover="ddrivetip('Haze','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent108" class="clickers" onmouseover="ddrivetip('Dust','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent109" class="clickers" onmouseover="ddrivetip('Terracotta','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent110" class="clickers" onmouseover="ddrivetip('Clay','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent111" class="clickers" onmouseover="ddrivetip('Shimmer','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent112" class="clickers" onmouseover="ddrivetip('Shade','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent113" class="clickers" onmouseover="ddrivetip('Canyon','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>                                
        <div style="clear:both;">
            <h2>Woven Tattles & Spun Tales</h2>
            <div id="accent114" class="clickers" onmouseover="ddrivetip('Muslin','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent115" class="clickers" onmouseover="ddrivetip('Toile','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent116" class="clickers" onmouseover="ddrivetip('Georgette','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent117" class="clickers" onmouseover="ddrivetip('Organza','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent118" class="clickers" onmouseover="ddrivetip('Shantung','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent119" class="clickers" onmouseover="ddrivetip('Blue Silk','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent120" class="clickers" onmouseover="ddrivetip('Leather','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent121" class="clickers" onmouseover="ddrivetip('Pique','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent122" class="clickers" onmouseover="ddrivetip('Piping','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent123" class="clickers" onmouseover="ddrivetip('Jacquard','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent124" class="clickers" onmouseover="ddrivetip('Damask','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="accent125" class="clickers" onmouseover="ddrivetip('Denim','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>                                
    </div>
</div>

<div class="simple_overlay" style="max-height:519px; overflow:scroll;" id="paint1-selector"> 
    <div id="paint1Colors">
        <h2>Paint 1 Color Options</h2>
        <div>
            <h2>Espresso Blends</h2>
            <div id="paint1-1" class="clickers" onmouseover="ddrivetip('Sumatra','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-2" class="clickers" onmouseover="ddrivetip('Mocha','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-3" class="clickers" onmouseover="ddrivetip('Steamer','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-4" class="clickers" onmouseover="ddrivetip('Roast','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-5" class="clickers" onmouseover="ddrivetip('Hazelnut','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-6" class="clickers" onmouseover="ddrivetip('Cappuccino','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-7" class="clickers" onmouseover="ddrivetip('Bavarian','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-8" class="clickers" onmouseover="ddrivetip('Green','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-9" class="clickers" onmouseover="ddrivetip('Cocoa','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-10" class="clickers" onmouseover="ddrivetip('Medallion','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>
        <div style="clear:both;">
            <h2>Natural Blondes</h2>
            <div id="paint1-11" class="clickers" onmouseover="ddrivetip('Butter','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-12" class="clickers" onmouseover="ddrivetip('Maple','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-13" class="clickers" onmouseover="ddrivetip('Honey','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-14" class="clickers" onmouseover="ddrivetip('Bamboo','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-15" class="clickers" onmouseover="ddrivetip('Manilla','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-16" class="clickers" onmouseover="ddrivetip('Teak','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-17" class="clickers" onmouseover="ddrivetip('Oak','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-18" class="clickers" onmouseover="ddrivetip('Straw','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-19" class="clickers" onmouseover="ddrivetip('Ale','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-20" class="clickers" onmouseover="ddrivetip('Gold','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-21" class="clickers" onmouseover="ddrivetip('Birch','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-22" class="clickers" onmouseover="ddrivetip('Cream','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>        
        <div style="clear:both;">
            <h2>Cool Grasses & Evergreens</h2>
            <div id="paint1-23" class="clickers" onmouseover="ddrivetip('Hosta','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-24" class="clickers" onmouseover="ddrivetip('Moss','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-25" class="clickers" onmouseover="ddrivetip('Cypress','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-26" class="clickers" onmouseover="ddrivetip('Spruce','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-27" class="clickers" onmouseover="ddrivetip('Fir','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-28" class="clickers" onmouseover="ddrivetip('Juniper','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-29" class="clickers" onmouseover="ddrivetip('Pine','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-30" class="clickers" onmouseover="ddrivetip('Blade','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-31" class="clickers" onmouseover="ddrivetip('Fescue','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-32" class="clickers" onmouseover="ddrivetip('Manzanita','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>        
        <div style="clear:both;">
            <h2>Valley Vineyards & Spice</h2>
            <div id="paint1-33" class="clickers" onmouseover="ddrivetip('Cayenne','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-34" class="clickers" onmouseover="ddrivetip('Ginger','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-35" class="clickers" onmouseover="ddrivetip('Spice','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-36" class="clickers" onmouseover="ddrivetip('Paprika','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-37" class="clickers" onmouseover="ddrivetip('Cabernet','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-38" class="clickers" onmouseover="ddrivetip('Bordeaux','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-39" class="clickers" onmouseover="ddrivetip('Pinot','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-40" class="clickers" onmouseover="ddrivetip('Merlot','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-41" class="clickers" onmouseover="ddrivetip('Shiraz','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-42" class="clickers" onmouseover="ddrivetip('Sangria','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-43" class="clickers" onmouseover="ddrivetip('Saffron','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-44" class="clickers" onmouseover="ddrivetip('Blush','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>        
        <div style="clear:both;">
            <h2>Silver Skies</h2>
            <div id="paint1-45" class="clickers" onmouseover="ddrivetip('Twilight','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-46" class="clickers" onmouseover="ddrivetip('Tempest','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-47" class="clickers" onmouseover="ddrivetip('Thunder','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-48" class="clickers" onmouseover="ddrivetip('Dusk','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-49" class="clickers" onmouseover="ddrivetip('Mist','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-50" class="clickers" onmouseover="ddrivetip('Fog','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-51" class="clickers" onmouseover="ddrivetip('Rain','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-52" class="clickers" onmouseover="ddrivetip('Storm','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-53" class="clickers" onmouseover="ddrivetip('Frost','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-54" class="clickers" onmouseover="ddrivetip('Wind','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-55" class="clickers" onmouseover="ddrivetip('Silver','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-56" class="clickers" onmouseover="ddrivetip('Skyline','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>  
        <div style="clear:both;">
            <h2>Ocean Tidepools</h2>
            <div id="paint1-57" class="clickers" onmouseover="ddrivetip('Blue','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-58" class="clickers" onmouseover="ddrivetip('Reef','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-59" class="clickers" onmouseover="ddrivetip('Breeze','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-60" class="clickers" onmouseover="ddrivetip('Reflection','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-61" class="clickers" onmouseover="ddrivetip('Foam','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-62" class="clickers" onmouseover="ddrivetip('Coast','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-63" class="clickers" onmouseover="ddrivetip('Cool','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-64" class="clickers" onmouseover="ddrivetip('Tide','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-65" class="clickers" onmouseover="ddrivetip('Swell','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-66" class="clickers" onmouseover="ddrivetip('Pool','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-67" class="clickers" onmouseover="ddrivetip('Current','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-68" class="clickers" onmouseover="ddrivetip('Spray','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>                                              
        <div style="clear:both;">
            <h2>Sweet & Hot Beans</h2>
            <div id="paint1-69" class="clickers" onmouseover="ddrivetip('Bananas & Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-70" class="clickers" onmouseover="ddrivetip('Kiwis & Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-71" class="clickers" onmouseover="ddrivetip('Full o Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-72" class="clickers" onmouseover="ddrivetip('Peaches & Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-73" class="clickers" onmouseover="ddrivetip('Mango Tango Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-74" class="clickers" onmouseover="ddrivetip('Passion Fashion Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-75" class="clickers" onmouseover="ddrivetip('Black & Blue Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-76" class="clickers" onmouseover="ddrivetip('Lemon Drop Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-77" class="clickers" onmouseover="ddrivetip('Pistachio Lime Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-78" class="clickers" onmouseover="ddrivetip('Berry Chili Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-79" class="clickers" onmouseover="ddrivetip('Berries & Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-80" class="clickers" onmouseover="ddrivetip('Grapes & Beans','#eee')"; onmouseout="hideddrivetip()"></div>
        </div> 
        <div style="clear:both;">
            <h2>Pebbles & Creams</h2>
            <div id="paint1-81" class="clickers" onmouseover="ddrivetip('Ash','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-82" class="clickers" onmouseover="ddrivetip('Feather','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-83" class="clickers" onmouseover="ddrivetip('Stone','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-84" class="clickers" onmouseover="ddrivetip('Pebble','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-85" class="clickers" onmouseover="ddrivetip('Whip','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-86" class="clickers" onmouseover="ddrivetip('Sand','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-87" class="clickers" onmouseover="ddrivetip('Custard','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-88" class="clickers" onmouseover="ddrivetip('Glass','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-89" class="clickers" onmouseover="ddrivetip('Shell','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-90" class="clickers" onmouseover="ddrivetip('Grain','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-91" class="clickers" onmouseover="ddrivetip('Vanilla','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-92" class="clickers" onmouseover="ddrivetip('Icing','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>                                
        <div style="clear:both;">
            <h2>Pacific Trail Mix</h2>
            <div id="paint1-93" class="clickers" onmouseover="ddrivetip('Crunch','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-94" class="clickers" onmouseover="ddrivetip('Olive','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-95" class="clickers" onmouseover="ddrivetip('Cashew','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-96" class="clickers" onmouseover="ddrivetip('Date','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-97" class="clickers" onmouseover="ddrivetip('Almond','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-98" class="clickers" onmouseover="ddrivetip('Pecan','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-99" class="clickers" onmouseover="ddrivetip('Macadamia','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-100" class="clickers" onmouseover="ddrivetip('Peanut','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-101" class="clickers" onmouseover="ddrivetip('Filbert','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-102" class="clickers" onmouseover="ddrivetip('Oat','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-103" class="clickers" onmouseover="ddrivetip('Ginseng','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>                                
        <div style="clear:both;">
            <h2>Desert Lights</h2>
            <div id="paint1-104" class="clickers" onmouseover="ddrivetip('Mesa','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-105" class="clickers" onmouseover="ddrivetip('Brick','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-106" class="clickers" onmouseover="ddrivetip('Glow','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-107" class="clickers" onmouseover="ddrivetip('Haze','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-108" class="clickers" onmouseover="ddrivetip('Dust','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-109" class="clickers" onmouseover="ddrivetip('Terracotta','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-110" class="clickers" onmouseover="ddrivetip('Clay','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-111" class="clickers" onmouseover="ddrivetip('Shimmer','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-112" class="clickers" onmouseover="ddrivetip('Shade','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-113" class="clickers" onmouseover="ddrivetip('Canyon','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>                                
        <div style="clear:both;">
            <h2>Woven Tattles & Spun Tales</h2>
            <div id="paint1-114" class="clickers" onmouseover="ddrivetip('Muslin','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-115" class="clickers" onmouseover="ddrivetip('Toile','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-116" class="clickers" onmouseover="ddrivetip('Georgette','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-117" class="clickers" onmouseover="ddrivetip('Organza','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-118" class="clickers" onmouseover="ddrivetip('Shantung','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-119" class="clickers" onmouseover="ddrivetip('Blue Silk','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-120" class="clickers" onmouseover="ddrivetip('Leather','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-121" class="clickers" onmouseover="ddrivetip('Pique','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-122" class="clickers" onmouseover="ddrivetip('Piping','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-123" class="clickers" onmouseover="ddrivetip('Jacquard','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-124" class="clickers" onmouseover="ddrivetip('Damask','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint1-125" class="clickers" onmouseover="ddrivetip('Denim','#eee')"; onmouseout="hideddrivetip()"></div>
        </div> 
    </div>
</div>
    
<div class="simple_overlay" style="max-height:519px; overflow:scroll;" id="paint2-selector"> 
    <div id="paint2Colors">
        <h2>Paint 2 Color Options</h2>
        <div>
            <h2>Espresso Blends</h2>
            <div id="paint2-1" class="clickers" onmouseover="ddrivetip('Sumatra','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-2" class="clickers" onmouseover="ddrivetip('Mocha','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-3" class="clickers" onmouseover="ddrivetip('Steamer','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-4" class="clickers" onmouseover="ddrivetip('Roast','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-5" class="clickers" onmouseover="ddrivetip('Hazelnut','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-6" class="clickers" onmouseover="ddrivetip('Cappuccino','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-7" class="clickers" onmouseover="ddrivetip('Bavarian','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-8" class="clickers" onmouseover="ddrivetip('Green','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-9" class="clickers" onmouseover="ddrivetip('Cocoa','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-10" class="clickers" onmouseover="ddrivetip('Medallion','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>
        <div style="clear:both;">
            <h2>Natural Blondes</h2>
            <div id="paint2-11" class="clickers" onmouseover="ddrivetip('Butter','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-12" class="clickers" onmouseover="ddrivetip('Maple','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-13" class="clickers" onmouseover="ddrivetip('Honey','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-14" class="clickers" onmouseover="ddrivetip('Bamboo','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-15" class="clickers" onmouseover="ddrivetip('Manilla','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-16" class="clickers" onmouseover="ddrivetip('Teak','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-17" class="clickers" onmouseover="ddrivetip('Oak','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-18" class="clickers" onmouseover="ddrivetip('Straw','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-19" class="clickers" onmouseover="ddrivetip('Ale','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-20" class="clickers" onmouseover="ddrivetip('Gold','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-21" class="clickers" onmouseover="ddrivetip('Birch','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-22" class="clickers" onmouseover="ddrivetip('Cream','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>        
        <div style="clear:both;">
            <h2>Cool Grasses & Evergreens</h2>
            <div id="paint2-23" class="clickers" onmouseover="ddrivetip('Hosta','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-24" class="clickers" onmouseover="ddrivetip('Moss','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-25" class="clickers" onmouseover="ddrivetip('Cypress','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-26" class="clickers" onmouseover="ddrivetip('Spruce','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-27" class="clickers" onmouseover="ddrivetip('Fir','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-28" class="clickers" onmouseover="ddrivetip('Juniper','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-29" class="clickers" onmouseover="ddrivetip('Pine','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-30" class="clickers" onmouseover="ddrivetip('Blade','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-31" class="clickers" onmouseover="ddrivetip('Fescue','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-32" class="clickers" onmouseover="ddrivetip('Manzanita','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>        
        <div style="clear:both;">
            <h2>Valley Vineyards & Spice</h2>
            <div id="paint2-33" class="clickers" onmouseover="ddrivetip('Cayenne','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-34" class="clickers" onmouseover="ddrivetip('Ginger','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-35" class="clickers" onmouseover="ddrivetip('Spice','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-36" class="clickers" onmouseover="ddrivetip('Paprika','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-37" class="clickers" onmouseover="ddrivetip('Cabernet','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-38" class="clickers" onmouseover="ddrivetip('Bordeaux','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-39" class="clickers" onmouseover="ddrivetip('Pinot','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-40" class="clickers" onmouseover="ddrivetip('Merlot','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-41" class="clickers" onmouseover="ddrivetip('Shiraz','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-42" class="clickers" onmouseover="ddrivetip('Sangria','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-43" class="clickers" onmouseover="ddrivetip('Saffron','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-44" class="clickers" onmouseover="ddrivetip('Blush','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>        
        <div style="clear:both;">
            <h2>Silver Skies</h2>
            <div id="paint2-45" class="clickers" onmouseover="ddrivetip('Twilight','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-46" class="clickers" onmouseover="ddrivetip('Tempest','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-47" class="clickers" onmouseover="ddrivetip('Thunder','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-48" class="clickers" onmouseover="ddrivetip('Dusk','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-49" class="clickers" onmouseover="ddrivetip('Mist','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-50" class="clickers" onmouseover="ddrivetip('Fog','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-51" class="clickers" onmouseover="ddrivetip('Rain','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-52" class="clickers" onmouseover="ddrivetip('Storm','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-53" class="clickers" onmouseover="ddrivetip('Frost','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-54" class="clickers" onmouseover="ddrivetip('Wind','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-55" class="clickers" onmouseover="ddrivetip('Silver','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-56" class="clickers" onmouseover="ddrivetip('Skyline','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>  
        <div style="clear:both;">
            <h2>Ocean Tidepools</h2>
            <div id="paint2-57" class="clickers" onmouseover="ddrivetip('Blue','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-58" class="clickers" onmouseover="ddrivetip('Reef','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-59" class="clickers" onmouseover="ddrivetip('Breeze','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-60" class="clickers" onmouseover="ddrivetip('Reflection','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-61" class="clickers" onmouseover="ddrivetip('Foam','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-62" class="clickers" onmouseover="ddrivetip('Coast','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-63" class="clickers" onmouseover="ddrivetip('Cool','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-64" class="clickers" onmouseover="ddrivetip('Tide','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-65" class="clickers" onmouseover="ddrivetip('Swell','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-66" class="clickers" onmouseover="ddrivetip('Pool','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-67" class="clickers" onmouseover="ddrivetip('Current','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-68" class="clickers" onmouseover="ddrivetip('Spray','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>                                              
        <div style="clear:both;">
            <h2>Sweet & Hot Beans</h2>
            <div id="paint2-69" class="clickers" onmouseover="ddrivetip('Bananas & Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-70" class="clickers" onmouseover="ddrivetip('Kiwis & Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-71" class="clickers" onmouseover="ddrivetip('Full o Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-72" class="clickers" onmouseover="ddrivetip('Peaches & Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-73" class="clickers" onmouseover="ddrivetip('Mango Tango Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-74" class="clickers" onmouseover="ddrivetip('Passion Fashion Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-75" class="clickers" onmouseover="ddrivetip('Black & Blue Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-76" class="clickers" onmouseover="ddrivetip('Lemon Drop Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-77" class="clickers" onmouseover="ddrivetip('Pistachio Lime Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-78" class="clickers" onmouseover="ddrivetip('Berry Chili Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-79" class="clickers" onmouseover="ddrivetip('Berries & Beans','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-80" class="clickers" onmouseover="ddrivetip('Grapes & Beans','#eee')"; onmouseout="hideddrivetip()"></div>
        </div> 
        <div style="clear:both;">
            <h2>Pebbles & Creams</h2>
            <div id="paint2-81" class="clickers" onmouseover="ddrivetip('Ash','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-82" class="clickers" onmouseover="ddrivetip('Feather','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-83" class="clickers" onmouseover="ddrivetip('Stone','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-84" class="clickers" onmouseover="ddrivetip('Pebble','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-85" class="clickers" onmouseover="ddrivetip('Whip','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-86" class="clickers" onmouseover="ddrivetip('Sand','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-87" class="clickers" onmouseover="ddrivetip('Custard','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-88" class="clickers" onmouseover="ddrivetip('Glass','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-89" class="clickers" onmouseover="ddrivetip('Shell','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-90" class="clickers" onmouseover="ddrivetip('Grain','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-91" class="clickers" onmouseover="ddrivetip('Vanilla','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-92" class="clickers" onmouseover="ddrivetip('Icing','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>                                
        <div style="clear:both;">
            <h2>Pacific Trail Mix</h2>
            <div id="paint2-93" class="clickers" onmouseover="ddrivetip('Crunch','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-94" class="clickers" onmouseover="ddrivetip('Olive','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-95" class="clickers" onmouseover="ddrivetip('Cashew','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-96" class="clickers" onmouseover="ddrivetip('Date','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-97" class="clickers" onmouseover="ddrivetip('Almond','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-98" class="clickers" onmouseover="ddrivetip('Pecan','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-99" class="clickers" onmouseover="ddrivetip('Macadamia','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-100" class="clickers" onmouseover="ddrivetip('Peanut','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-101" class="clickers" onmouseover="ddrivetip('Filbert','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-102" class="clickers" onmouseover="ddrivetip('Oat','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-103" class="clickers" onmouseover="ddrivetip('Ginseng','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>                                
        <div style="clear:both;">
            <h2>Desert Lights</h2>
            <div id="paint2-104" class="clickers" onmouseover="ddrivetip('Mesa','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-105" class="clickers" onmouseover="ddrivetip('Brick','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-106" class="clickers" onmouseover="ddrivetip('Glow','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-107" class="clickers" onmouseover="ddrivetip('Haze','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-108" class="clickers" onmouseover="ddrivetip('Dust','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-109" class="clickers" onmouseover="ddrivetip('Terracotta','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-110" class="clickers" onmouseover="ddrivetip('Clay','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-111" class="clickers" onmouseover="ddrivetip('Shimmer','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-112" class="clickers" onmouseover="ddrivetip('Shade','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-113" class="clickers" onmouseover="ddrivetip('Canyon','#eee')"; onmouseout="hideddrivetip()"></div>
        </div>                                
        <div style="clear:both;">
            <h2>Woven Tattles & Spun Tales</h2>
            <div id="paint2-114" class="clickers" onmouseover="ddrivetip('Muslin','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-115" class="clickers" onmouseover="ddrivetip('Toile','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-116" class="clickers" onmouseover="ddrivetip('Georgette','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-117" class="clickers" onmouseover="ddrivetip('Organza','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-118" class="clickers" onmouseover="ddrivetip('Shantung','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-119" class="clickers" onmouseover="ddrivetip('Blue Silk','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-120" class="clickers" onmouseover="ddrivetip('Leather','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-121" class="clickers" onmouseover="ddrivetip('Pique','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-122" class="clickers" onmouseover="ddrivetip('Piping','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-123" class="clickers" onmouseover="ddrivetip('Jacquard','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-124" class="clickers" onmouseover="ddrivetip('Damask','#eee')"; onmouseout="hideddrivetip()"></div>
            <div id="paint2-125" class="clickers" onmouseover="ddrivetip('Denim','#eee')"; onmouseout="hideddrivetip()"></div>
        </div> 
    </div>
</div>

</asp:Content>
