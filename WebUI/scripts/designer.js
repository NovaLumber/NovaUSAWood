﻿function savedesign() {
    var myValue = document.getElementById('paint1-code').innerHTML +","+ document.getElementById('paint1-desc').innerHTML +","
        + document.getElementById('paint2-code').innerHTML +","+ document.getElementById('paint2-desc').innerHTML +","
        + document.getElementById('accent-code').innerHTML +","+ document.getElementById('accent-desc').innerHTML +","
        + document.getElementById('counter-file').innerHTML +","+ document.getElementById('counter-desc').innerHTML +","
        + document.getElementById('cabinet-file').innerHTML +","+ document.getElementById('cabinet-desc').innerHTML +","
        + document.getElementById('molding-file').innerHTML +","+ document.getElementById('molding-desc').innerHTML +","
        + document.getElementById('flooring-file').innerHTML +","+ document.getElementById('flooring-desc').innerHTML;
    
    $.cookie("thedesign", myValue, { expires: 30 });
}

function loaddesign(stylelist) {
    var stylearray = new Array(100);
    stylearray = stylelist.split(",");

    setpaint1(stylearray[0], stylearray[1]);
    setpaint2(stylearray[2], stylearray[3]);
    setaccent(stylearray[4], stylearray[5]);    
    setcounterimage(stylearray[6], stylearray[7]);
    setcabinetimage(stylearray[8], stylearray[9]);
    setmoldingimage(stylearray[10], stylearray[11]);
    setflooringimage(stylearray[12], stylearray[13]);
}

function loadlastdesign() {
    loaddesign( $.cookie("thedesign") );
};

function design1() {
    setmoldingimage("white-molding.jpg", "White");
    setflooringimage("acacia-rosewood.jpg", "Acacia Rosewood Handscraped - Elemental Heritage by Nova");
    setcounterimage("tan-brown.jpg", "Tan Brown");
    setcabinetimage("walnut-cab.jpg", "Walnut");
    setpaint1("#CA9C42", "Ale");
    setpaint2("#752E21", "Sangria");
    setaccent("#FFF9C1", "Butter");
};
function design2() {
    setmoldingimage("white-molding.jpg", "White");
    setflooringimage("ipe.jpg", "Ipe, Brazilian Walnut - Elemental Exotics by Nova");
    setcounterimage("bianco-sardo-flamed.jpg", "Bianco Sardo Flamed");
    setcabinetimage("maple-cab.jpg", "Maple");
    setpaint1("#EBE8C7", "Feather");
    setpaint2("#AC9C69", "Mocha");
    setaccent("#E5BD7F", "Clay");
};
function design3() {
    setmoldingimage("white-molding.jpg", "White");
    setflooringimage("brazilian-cherry.jpg", "Brazilian Cherry - Elemental Exotics by Nova");
    setcounterimage("cambrian-black.bmp", "Cambrian Black");
    setcabinetimage("red-oak-cab.jpg", "Red Oak");
    setpaint1("#D9CB80", "Oat");
    setpaint2("#7D332D", "Paprika");
    setaccent("#B57843", "Dust");
};

//Devine Brand Paint 1: Capuccino, Paint 2: Medallion, Accent Paint: Cocoa 
//Counter: Gialo Veneziano, Cabinet: Walnut, Molding: White, Flooring: Lapacho Ipe - Elemental Exotics by Nova

function setaccent(color, name){
  $("#accent-vertical").css("background-image","none");
  $("#accent-horizontal").css("background-image","none");
  $("#accent-vertical").css("background-color", color);
  $("#accent-horizontal").css("background-color", color);
  $("#legend-accent").text("Accent Paint: " + name + " ");
  $("#accent-code").text(color);
  $("#accent-desc").text(name);  
};

function setpaint1(color, name){
  $("#paint1").css("background-image","none");
  $("#paint1").css("background-color", color);
  $("#legend-paint1").text("Devine Brand Paint 1: "+name+", ");
  $("#paint1-code").text(color);
  $("#paint1-desc").text(name);  
};

function setpaint2(color, name){
  $("#paint2").css("background-image","none");
  $("#paint2").css("background-color", color);
  $("#legend-paint2").text("Paint 2: " + name + ", ");
  $("#paint2-code").text(color);
  $("#paint2-desc").text(name);  
};

function setflooringimage(filename, name){
  $("#flooring").css("background-image","url(../images/designer/floor/"+filename+")" );      
  $("#legend-flooring").text("Flooring: "+name);
  $("#flooring-file").text(filename);
  $("#flooring-desc").text(name);  
};

function setcounterimage(filename, name){
  $("#counter").css("background-image","url(../images/designer/counter/"+filename+")" );      
  $("#legend-counter").text("Counter: "+name+", ");
  $("#counter-file").text(filename);
  $("#counter-desc").text(name);  
};

function setcabinetimage(filename, name){
  $("#cabinet").css("background-image","url(../images/designer/cabinet/"+filename+")" );      
  $("#legend-cabinet").text("Cabinet: "+name+", ");
  $("#cabinet-file").text(filename);
  $("#cabinet-desc").text(name);  
};

function setmoldingimage(filename, name){
  $("#molding").css("background-image","url(../images/designer/molding/"+filename+")" );      
  $("#legend-molding").text("Molding: "+name+", ");
  $("#molding-file").text(filename);
  $("#molding-desc").text(name);  
};

function settileimage(filename, name){
  $("#tile").css("background-image","url(../images/designer/tile/"+filename+")" );      
  $("#legend-tile").text("Tile: "+name+", ");
};

$(document).ready(function() {

    $("img[rel]").overlay();
        
    $("div#floor1").click(function() {setflooringimage("acacia-natural.jpg", "Acacia Natural - Elemental World by Nova"); });
    $("div#floor2").click(function() {setflooringimage("acacia-rosewood.jpg", "Acacia Rosewood Handscraped - Elemental Heritage by Nova"); });
    $("div#floor3").click(function() {setflooringimage("amendoim.jpg", "Amendoim - Elemental Exotic by Nova"); });
    $("div#floor4").click(function() {setflooringimage("birch-natural.jpg", "Birch Natural - Elemental Classics by Nova"); });
    $("div#floor5").click(function() {setflooringimage("brazilian-cherry.jpg", "Brazilian Cherry / Jatoba - Elemental Exotics by Nova"); });
    $("div#floor6").click(function() {setflooringimage("cumaru.jpg", "Cumaru - Elemental Exotics by Nova"); });
    $("div#floor7").click(function() {setflooringimage("ipe.jpg", "Ipe / Brazilian Walnut - Elemental Exotics by Nova"); });
    $("div#floor8").click(function() {setflooringimage("kurupayra.jpg", "Kurupayra, Angico - Elemental Exotics by Nova"); });
    $("div#floor9").click(function() {setflooringimage("lapacho-ipe.jpg", "Lapacho Ipe - Elemental Exotics by Nova"); });
    $("div#floor10").click(function() {setflooringimage("massaranduba.jpg", "Brazilian Redwood / Massaranduba - Elemental Exotics by Nova"); });
    $("div#floor11").click(function() {setflooringimage("para-rosewood.jpg", "Para Rosewood - Elemental Exotics by Nova"); });
    $("div#floor12").click(function() {setflooringimage("patagonian-rosewood.jpg", "Patagonian Rosewood / Curupau - Elemental Exotics by Nova"); });
    $("div#floor13").click(function() {setflooringimage("red-oak.jpg", "Red Oak Natural - Elemental Classics by Nova"); });
    $("div#floor14").click(function() {setflooringimage("tarara.jpg", "Canarywood / Tarara - Elemental Exotics by Nova"); });
    $("div#floor15").click(function() {setflooringimage("tiete-rosewood.jpg", "Tiete Rosewood / Sirari - Elemental Exotics by Nova"); });
    $("div#floor16").click(function() {setflooringimage("tigerwood.jpg", "Tigerwood - Elemental Exotics by Nova"); });

    $("div#counter1").click(function() {setcounterimage("black-galaxy.jpg", "Black Galaxy"); });
    $("div#counter2").click(function() {setcounterimage("cambrian-black.jpg", "Cambrian Black"); });
    $("div#counter3").click(function() {setcounterimage("bianco-sardo-flamed.jpg", "Bianco Sardo Flamed"); });
    $("div#counter4").click(function() {setcounterimage("blue-pearl.jpg", "Blue Pearl"); });
    $("div#counter5").click(function() {setcounterimage("gialo-veneziano.jpg", "Gialo Veneziano"); });
    $("div#counter6").click(function() {setcounterimage("red-multi-color.jpg", "Red Multi Color"); });
    $("div#counter7").click(function() {setcounterimage("silver-pearl.jpg", "Silver Pearl"); });
    $("div#counter8").click(function() {setcounterimage("tan-brown.jpg", "Tan Brown"); });
    $("div#counter9").click(function() {setcounterimage("ubatuba.jpg", "Ubatuba"); });
    $("div#counter10").click(function() {setcounterimage("verde-crystal.jpg", "Verde Crystal"); });

    $("div#cabinet1").click(function() {setcabinetimage("red-oak-cab.jpg", "Red Oak"); });
    $("div#cabinet2").click(function() {setcabinetimage("maple-cab.jpg", "Maple"); });
    $("div#cabinet3").click(function() {setcabinetimage("walnut-cab.jpg", "Walnut"); });
    $("div#cabinet4").click(function() {setcabinetimage("fir-cab.jpg", "Douglas Fir"); });
    $("div#cabinet5").click(function() {setcabinetimage("cherry-cab.jpg", "Cherry"); });
    $("div#cabinet6").click(function() {setcabinetimage("white-cab.jpg", "White"); });
    $("div#cabinet7").click(function() {setcabinetimage("almond-cab.jpg", "Almond"); });
    $("div#cabinet8").click(function() {setcabinetimage("knotty-pine-cab.jpg", "Knotty Pine"); });
    $("div#cabinet9").click(function() {setcabinetimage("white-oak-cab.jpg", "White Oak"); });
    $("div#cabinet10").click(function() {setcabinetimage("white-oak-tuscany-cab.jpg", "White Oak Tuscany"); });
    $("div#cabinet11").click(function() {setcabinetimage("spruce-cab.jpg", "Spruce"); });

    $("div#molding1").click(function() {setmoldingimage("white-molding.jpg", "White"); });
    $("div#molding2").click(function() {setmoldingimage("almond-molding.jpg", "Almond"); });
    $("div#molding3").click(function() {setmoldingimage("red-oak-molding.jpg", "Red Oak"); });
    $("div#molding4").click(function() {setmoldingimage("maple-molding.jpg", "Maple"); });
    $("div#molding5").click(function() {setmoldingimage("cherry-molding.jpg", "Cherry"); });
    $("div#molding6").click(function() {setmoldingimage("mahogany-molding.jpg", "Mahogany"); });
    $("div#molding7").click(function() {setmoldingimage("fir-molding.jpg", "Douglas Fir"); });

    $("div#tile1").click(function() { settileimage("none", "None"); });
    $("div#tile2").click(function() { settileimage("tile-gray-1.JPG", "Natural Gray"); });

    $("#accent1").click(function(){ setaccent("#B9A36B", "Sumatra"); });
    $("#accent2").click(function(){ setaccent("#AC9C69", "Mocha"); });   
    $("#accent3").click(function(){ setaccent("#82917B", "Steamer"); });
    $("#accent4").click(function(){ setaccent("#8E8C5C", "Steamer"); });
    $("#accent5").click(function(){ setaccent("#AA9D5C", "Hazelnut"); });
    $("#accent6").click(function(){ setaccent("#DACEB6", "Capuccino"); });
    $("#accent7").click(function(){ setaccent("#A1917F", "Bavarian"); });
    $("#accent8").click(function(){ setaccent("#8C8D4A", "Green Tea"); });
    $("#accent9").click(function(){ setaccent("#564422", "Cocoa"); });
    $("#accent10").click(function(){ setaccent("#BAA872", "Medallion"); });
    $("#accent11").click(function(){ setaccent("#FFF9C1", "Butter"); });
    $("#accent12").click(function(){ setaccent("#F1EC9F", "Maple"); });
    $("#accent13").click(function(){ setaccent("#E0CA73", "Honey"); });
    $("#accent14").click(function(){ setaccent("#ECE399", "Bamboo"); });
    $("#accent15").click(function(){ setaccent("#E6DB6B", "Manilla"); });
    $("#accent16").click(function(){ setaccent("#C78F3F", "Teak"); });
    $("#accent17").click(function(){ setaccent("#D3C17F", "Oak"); });
    $("#accent18").click(function(){ setaccent("#E0BD62", "Straw"); });
    $("#accent19").click(function(){ setaccent("#CA9C42", "Ale"); });
    $("#accent20").click(function(){ setaccent("#E0BC4E", "Gold"); });
    $("#accent21").click(function(){ setaccent("#F5EA95", "Birch"); });
    $("#accent22").click(function(){ setaccent("#FFF696", "Cream"); });
    $("#accent23").click(function(){ setaccent("#829680", "Hosta"); });
    $("#accent24").click(function(){ setaccent("#AEB196", "Moss"); });
    $("#accent25").click(function(){ setaccent("#A9BB89", "Cypress"); });
    $("#accent26").click(function(){ setaccent("#436152", "Spruce"); });
    $("#accent27").click(function(){ setaccent("#476F56", "Fir"); });
    $("#accent28").click(function(){ setaccent("#668461", "Juniper"); });
    $("#accent29").click(function(){ setaccent("#526653", "Pine"); });
    $("#accent30").click(function(){ setaccent("#D6E4C3", "Blade"); });
    $("#accent31").click(function(){ setaccent("#DCE1C1", "Fescue"); });
    $("#accent32").click(function(){ setaccent("#B8C49E", "Manzanita"); });
    $("#accent33").click(function(){ setaccent("#8D2824", "Cayenne"); });
    $("#accent34").click(function(){ setaccent("#803F32", "Ginger"); });
    $("#accent35").click(function(){ setaccent("#73391E", "Spice"); });
    $("#accent36").click(function(){ setaccent("#7D332D", "Paprika"); });
    $("#accent37").click(function(){ setaccent("#6F2127", "Cabernet"); });
    $("#accent38").click(function(){ setaccent("#602524", "Bordeaux"); });
    $("#accent39").click(function(){ setaccent("#552A36", "Pinot"); });
    $("#accent40").click(function(){ setaccent("#7F3C3E", "Merlot"); });
    $("#accent41").click(function(){ setaccent("#6E4348", "Shiraz"); });
    $("#accent42").click(function(){ setaccent("#752E21", "Sangria"); });
    $("#accent43").click(function(){ setaccent("#9E2F34", "Saffron"); });
    $("#accent44").click(function(){ setaccent("#AD4A3A", "Blush"); });
    $("#accent45").click(function(){ setaccent("#9F8D8E", "Twilight"); });
    $("#accent46").click(function(){ setaccent("#A58F94", "Tempest"); });
    $("#accent47").click(function(){ setaccent("#9F8C8F", "Thunder"); });
    $("#accent48").click(function(){ setaccent("#6D4B5A", "Dusk"); });
    $("#accent49").click(function(){ setaccent("#CBB3A1", "Mist"); });
    $("#accent50").click(function(){ setaccent("#C2C6C6", "Fog"); });
    $("#accent51").click(function(){ setaccent("#979CA3", "Rain"); });
    $("#accent52").click(function(){ setaccent("#767A86", "Storm"); });
    $("#accent53").click(function(){ setaccent("#E9E8EA", "Frost"); });
    $("#accent54").click(function(){ setaccent("#DEDADC", "Wind"); });  
    $("#accent55").click(function(){ setaccent("#E4E7E8", "Silver"); });  
    $("#accent56").click(function(){ setaccent("#9897A4", "Skyline"); }); 
    $("#accent57").click(function(){ setaccent("#CCDCE4", "Blue"); });
    $("#accent58").click(function(){ setaccent("#DCE3CC", "Reef"); });
    $("#accent59").click(function(){ setaccent("#DEE7D5", "Breeze"); });
    $("#accent60").click(function(){ setaccent("#BED0C2", "Reflection"); });
    $("#accent61").click(function(){ setaccent("#648C80", "Foam"); });
    $("#accent62").click(function(){ setaccent("#5C7A8C", "Coast"); });
    $("#accent63").click(function(){ setaccent("#475B6F", "Cool"); });
    $("#accent64").click(function(){ setaccent("#566688", "Tide"); });  
    $("#accent65").click(function(){ setaccent("#6C7D99", "Swell"); });  
    $("#accent66").click(function(){ setaccent("#8395B2", "Pool"); });       
    $("#accent67").click(function(){ setaccent("#9BABBE", "Current"); });  
    $("#accent68").click(function(){ setaccent("#B1BBC3", "Spray"); });       
    $("#accent69").click(function(){ setaccent("#FFF1CA", "Bananas & Beans"); });
    $("#accent70").click(function(){ setaccent("#C8F0D0", "Kiwis & Beans"); });
    $("#accent71").click(function(){ setaccent("#B0D0E1", "Full o Beans"); });
    $("#accent72").click(function(){ setaccent("#FFEAC4", "Peaches & Beans"); });
    $("#accent73").click(function(){ setaccent("#FCD471", "Mango Tango Beans"); });
    $("#accent74").click(function(){ setaccent("#8A5A8B", "Passion Fashion Beans"); });  
    $("#accent75").click(function(){ setaccent("#373E61", "Black & Blue Beans"); });  
    $("#accent76").click(function(){ setaccent("#EBD670", "Lemon Drop Beans"); });       
    $("#accent77").click(function(){ setaccent("#94A74A", "Pistachio Lime Beans"); });  
    $("#accent78").click(function(){ setaccent("#942F5C", "Berry Chili Beans"); });       
    $("#accent79").click(function(){ setaccent("#FAD0D6", "Berries & Beans"); });
    $("#accent80").click(function(){ setaccent("#EBC6F5", "Grapes & Beans"); });
    $("#accent81").click(function(){ setaccent("#EAE3C6", "Ash"); });
    $("#accent82").click(function(){ setaccent("#EBE8C7", "Feather"); });
    $("#accent83").click(function(){ setaccent("#E5DFBF", "Stone"); });
    $("#accent84").click(function(){ setaccent("#E8E0B9", "Pebble"); });
    $("#accent85").click(function(){ setaccent("#F3F2DD", "Whip"); });
    $("#accent86").click(function(){ setaccent("#EDE39C", "Sand"); });
    $("#accent87").click(function(){ setaccent("#EFEAC2", "Custard"); });
    $("#accent88").click(function(){ setaccent("#BABE9B", "Glass"); });
    $("#accent89").click(function(){ setaccent("#EAE9BB", "Shell"); });
    $("#accent90").click(function(){ setaccent("#EBE7CC", "Grain"); });
    $("#accent91").click(function(){ setaccent("#ECF0CF", "Vanilla"); });
    $("#accent92").click(function(){ setaccent("#F6F5F0", "Icing"); });  
    $("#accent93").click(function(){ setaccent("#DBDBB5", "Crunch"); });
    $("#accent94").click(function(){ setaccent("#C1C593", "Olive"); });
    $("#accent95").click(function(){ setaccent("#D9B67C", "Cashew"); });
    $("#accent96").click(function(){ setaccent("#B0BFA0", "Date"); });
    $("#accent97").click(function(){ setaccent("#ADB8A8", "Almond"); });
    $("#accent98").click(function(){ setaccent("#CAC08F", "Pecan"); });
    $("#accent99").click(function(){ setaccent("#E3DFAF", "Macadamia"); });
    $("#accent100").click(function(){ setaccent("#DCC47C", "Peanut"); });
    $("#accent101").click(function(){ setaccent("#D7C185", "Filbert"); });
    $("#accent102").click(function(){ setaccent("#D9CB80", "Oat"); });
    $("#accent103").click(function(){ setaccent("#D2CEB3", "Ginseng"); });
    $("#accent104").click(function(){ setaccent("#B86850", "Mesa"); });
    $("#accent105").click(function(){ setaccent("#C48661", "Brick"); });
    $("#accent106").click(function(){ setaccent("#F1C473", "Glow"); });
    $("#accent107").click(function(){ setaccent("#BC5741", "Haze"); });
    $("#accent108").click(function(){ setaccent("#B57843", "Dust"); });
    $("#accent109").click(function(){ setaccent("#C78657", "Terracotta"); });
    $("#accent110").click(function(){ setaccent("#E5BD7F", "Clay"); });
    $("#accent111").click(function(){ setaccent("#E6D7AC", "Shimmer"); });
    $("#accent112").click(function(){ setaccent("#D2BA7C", "Shade"); });
    $("#accent113").click(function(){ setaccent("#C39B7C", "Canyon"); });
    $("#accent114").click(function(){ setaccent("#D0C293", "Muslin"); });  
    $("#accent115").click(function(){ setaccent("#8D3833", "Toile"); });
    $("#accent116").click(function(){ setaccent("#667E5E", "Georgette"); });
    $("#accent117").click(function(){ setaccent("#E3C474", "Organza"); });
    $("#accent118").click(function(){ setaccent("#472C3B", "Shantung"); });
    $("#accent119").click(function(){ setaccent("#444766", "Blue Silk"); });
    $("#accent120").click(function(){ setaccent("#1B1612", "Leather"); });
    $("#accent121").click(function(){ setaccent("#F4F3F1", "Pique"); });
    $("#accent122").click(function(){ setaccent("#3C382D", "Piping"); });
    $("#accent123").click(function(){ setaccent("#3F3D14", "Jacquard"); });
    $("#accent124").click(function(){ setaccent("#6F3241", "Damask"); });  
    $("#accent125").click(function(){ setaccent("#4C4F58", "Denim"); });  
    
    $("#paint1-1").click(function(){ setpaint1("#B9A36B", "Sumatra"); });
    $("#paint1-2").click(function(){ setpaint1("#AC9C69", "Mocha"); });   
    $("#paint1-3").click(function(){ setpaint1("#82917B", "Steamer"); });
    $("#paint1-4").click(function(){ setpaint1("#8E8C5C", "Steamer"); });
    $("#paint1-5").click(function(){ setpaint1("#AA9D5C", "Hazelnut"); });
    $("#paint1-6").click(function(){ setpaint1("#DACEB6", "Capuccino"); });
    $("#paint1-7").click(function(){ setpaint1("#A1917F", "Bavarian"); });
    $("#paint1-8").click(function(){ setpaint1("#8C8D4A", "Green Tea"); });
    $("#paint1-9").click(function(){ setpaint1("#564422", "Cocoa"); });
    $("#paint1-10").click(function(){ setpaint1("#BAA872", "Medallion"); });
    $("#paint1-11").click(function(){ setpaint1("#FFF9C1", "Butter"); });
    $("#paint1-12").click(function(){ setpaint1("#F1EC9F", "Maple"); });
    $("#paint1-13").click(function(){ setpaint1("#E0CA73", "Honey"); });
    $("#paint1-14").click(function(){ setpaint1("#ECE399", "Bamboo"); });
    $("#paint1-15").click(function(){ setpaint1("#E6DB6B", "Manilla"); });
    $("#paint1-16").click(function(){ setpaint1("#C78F3F", "Teak"); });
    $("#paint1-17").click(function(){ setpaint1("#D3C17F", "Oak"); });
    $("#paint1-18").click(function(){ setpaint1("#E0BD62", "Straw"); });
    $("#paint1-19").click(function(){ setpaint1("#CA9C42", "Ale"); });
    $("#paint1-20").click(function(){ setpaint1("#E0BC4E", "Gold"); });
    $("#paint1-21").click(function(){ setpaint1("#F5EA95", "Birch"); });
    $("#paint1-22").click(function(){ setpaint1("#FFF696", "Cream"); });  
    $("#paint1-23").click(function(){ setpaint1("#829680", "Hosta"); });
    $("#paint1-24").click(function(){ setpaint1("#AEB196", "Moss"); });
    $("#paint1-25").click(function(){ setpaint1("#A9BB89", "Cypress"); });
    $("#paint1-26").click(function(){ setpaint1("#436152", "Spruce"); });
    $("#paint1-27").click(function(){ setpaint1("#476F56", "Fir"); });
    $("#paint1-28").click(function(){ setpaint1("#668461", "Juniper"); });
    $("#paint1-29").click(function(){ setpaint1("#526653", "Pine"); });
    $("#paint1-30").click(function(){ setpaint1("#D6E4C3", "Blade"); });
    $("#paint1-31").click(function(){ setpaint1("#DCE1C1", "Fescue"); });
    $("#paint1-32").click(function(){ setpaint1("#B8C49E", "Manzanita"); });
    $("#paint1-33").click(function(){ setpaint1("#8D2824", "Cayenne"); });
    $("#paint1-34").click(function(){ setpaint1("#803F32", "Ginger"); });
    $("#paint1-35").click(function(){ setpaint1("#73391E", "Spice"); });
    $("#paint1-36").click(function(){ setpaint1("#7D332D", "Paprika"); });
    $("#paint1-37").click(function(){ setpaint1("#6F2127", "Cabernet"); });
    $("#paint1-38").click(function(){ setpaint1("#602524", "Bordeaux"); });
    $("#paint1-39").click(function(){ setpaint1("#552A36", "Pinot"); });
    $("#paint1-40").click(function(){ setpaint1("#7F3C3E", "Merlot"); });
    $("#paint1-41").click(function(){ setpaint1("#6E4348", "Shiraz"); });
    $("#paint1-42").click(function(){ setpaint1("#752E21", "Sangria"); });
    $("#paint1-43").click(function(){ setpaint1("#9E2F34", "Saffron"); });
    $("#paint1-44").click(function(){ setpaint1("#AD4A3A", "Blush"); });  
    $("#paint1-45").click(function(){ setpaint1("#9F8D8E", "Twilight"); });
    $("#paint1-46").click(function(){ setpaint1("#A58F94", "Tempest"); });
    $("#paint1-47").click(function(){ setpaint1("#9F8C8F", "Thunder"); });
    $("#paint1-48").click(function(){ setpaint1("#6D4B5A", "Dusk"); });
    $("#paint1-49").click(function(){ setpaint1("#CBB3A1", "Mist"); });
    $("#paint1-50").click(function(){ setpaint1("#C2C6C6", "Fog"); });
    $("#paint1-51").click(function(){ setpaint1("#979CA3", "Rain"); });
    $("#paint1-52").click(function(){ setpaint1("#767A86", "Storm"); });
    $("#paint1-53").click(function(){ setpaint1("#E9E8EA", "Frost"); });
    $("#paint1-54").click(function(){ setpaint1("#DEDADC", "Wind"); });  
    $("#paint1-55").click(function(){ setpaint1("#E4E7E8", "Silver"); });  
    $("#paint1-56").click(function(){ setpaint1("#9897A4", "Skyline"); });  
    $("#paint1-57").click(function(){ setpaint1("#CCDCE4", "Blue"); });
    $("#paint1-58").click(function(){ setpaint1("#DCE3CC", "Reef"); });
    $("#paint1-59").click(function(){ setpaint1("#DEE7D5", "Breeze"); });
    $("#paint1-60").click(function(){ setpaint1("#BED0C2", "Reflection"); });
    $("#paint1-61").click(function(){ setpaint1("#648C80", "Foam"); });
    $("#paint1-62").click(function(){ setpaint1("#5C7A8C", "Coast"); });
    $("#paint1-63").click(function(){ setpaint1("#475B6F", "Cool"); });
    $("#paint1-64").click(function(){ setpaint1("#566688", "Tide"); });  
    $("#paint1-65").click(function(){ setpaint1("#6C7D99", "Swell"); });  
    $("#paint1-66").click(function(){ setpaint1("#8395B2", "Pool"); });       
    $("#paint1-67").click(function(){ setpaint1("#9BABBE", "Current"); });  
    $("#paint1-68").click(function(){ setpaint1("#B1BBC3", "Spray"); });       
    $("#paint1-69").click(function(){ setpaint1("#FFF1CA", "Bananas & Beans"); });
    $("#paint1-70").click(function(){ setpaint1("#C8F0D0", "Kiwis & Beans"); });
    $("#paint1-71").click(function(){ setpaint1("#B0D0E1", "Full o Beans"); });
    $("#paint1-72").click(function(){ setpaint1("#FFEAC4", "Peaches & Beans"); });
    $("#paint1-73").click(function(){ setpaint1("#FCD471", "Mango Tango Beans"); });
    $("#paint1-74").click(function(){ setpaint1("#8A5A8B", "Passion Fashion Beans"); });  
    $("#paint1-75").click(function(){ setpaint1("#373E61", "Black & Blue Beans"); });  
    $("#paint1-76").click(function(){ setpaint1("#EBD670", "Lemon Drop Beans"); });       
    $("#paint1-77").click(function(){ setpaint1("#94A74A", "Pistachio Lime Beans"); });  
    $("#paint1-78").click(function(){ setpaint1("#942F5C", "Berry Chili Beans"); });       
    $("#paint1-79").click(function(){ setpaint1("#FAD0D6", "Berries & Beans"); });
    $("#paint1-80").click(function(){ setpaint1("#EBC6F5", "Grapes & Beans"); });
    $("#paint1-81").click(function(){ setpaint1("#EAE3C6", "Ash"); });
    $("#paint1-82").click(function(){ setpaint1("#EBE8C7", "Feather"); });
    $("#paint1-83").click(function(){ setpaint1("#E5DFBF", "Stone"); });
    $("#paint1-84").click(function(){ setpaint1("#E8E0B9", "Pebble"); });
    $("#paint1-85").click(function(){ setpaint1("#F3F2DD", "Whip"); });
    $("#paint1-86").click(function(){ setpaint1("#EDE39C", "Sand"); });
    $("#paint1-87").click(function(){ setpaint1("#EFEAC2", "Custard"); });
    $("#paint1-88").click(function(){ setpaint1("#BABE9B", "Glass"); });
    $("#paint1-89").click(function(){ setpaint1("#EAE9BB", "Shell"); });
    $("#paint1-90").click(function(){ setpaint1("#EBE7CC", "Grain"); });
    $("#paint1-91").click(function(){ setpaint1("#ECF0CF", "Vanilla"); });
    $("#paint1-92").click(function(){ setpaint1("#F6F5F0", "Icing"); });  
    $("#paint1-93").click(function(){ setpaint1("#DBDBB5", "Crunch"); });
    $("#paint1-94").click(function(){ setpaint1("#C1C593", "Olive"); });
    $("#paint1-95").click(function(){ setpaint1("#D9B67C", "Cashew"); });
    $("#paint1-96").click(function(){ setpaint1("#B0BFA0", "Date"); });
    $("#paint1-97").click(function(){ setpaint1("#ADB8A8", "Almond"); });
    $("#paint1-98").click(function(){ setpaint1("#CAC08F", "Pecan"); });
    $("#paint1-99").click(function(){ setpaint1("#E3DFAF", "Macadamia"); });
    $("#paint1-100").click(function(){ setpaint1("#DCC47C", "Peanut"); });
    $("#paint1-101").click(function(){ setpaint1("#D7C185", "Filbert"); });
    $("#paint1-102").click(function(){ setpaint1("#D9CB80", "Oat"); });
    $("#paint1-103").click(function(){ setpaint1("#D2CEB3", "Ginseng"); });
    $("#paint1-104").click(function(){ setpaint1("#B86850", "Mesa"); });
    $("#paint1-105").click(function(){ setpaint1("#C48661", "Brick"); });
    $("#paint1-106").click(function(){ setpaint1("#F1C473", "Glow"); });
    $("#paint1-107").click(function(){ setpaint1("#BC5741", "Haze"); });
    $("#paint1-108").click(function(){ setpaint1("#B57843", "Dust"); });
    $("#paint1-109").click(function(){ setpaint1("#C78657", "Terracotta"); });
    $("#paint1-110").click(function(){ setpaint1("#E5BD7F", "Clay"); });
    $("#paint1-111").click(function(){ setpaint1("#E6D7AC", "Shimmer"); });
    $("#paint1-112").click(function(){ setpaint1("#D2BA7C", "Shade"); });
    $("#paint1-113").click(function(){ setpaint1("#C39B7C", "Canyon"); });
    $("#paint1-114").click(function(){ setpaint1("#D0C293", "Muslin"); });  
    $("#paint1-115").click(function(){ setpaint1("#8D3833", "Toile"); });
    $("#paint1-116").click(function(){ setpaint1("#667E5E", "Georgette"); });
    $("#paint1-117").click(function(){ setpaint1("#E3C474", "Organza"); });
    $("#paint1-118").click(function(){ setpaint1("#472C3B", "Shantung"); });
    $("#paint1-119").click(function(){ setpaint1("#444766", "Blue Silk"); });
    $("#paint1-120").click(function(){ setpaint1("#1B1612", "Leather"); });
    $("#paint1-121").click(function(){ setpaint1("#F4F3F1", "Pique"); });
    $("#paint1-122").click(function(){ setpaint1("#3C382D", "Piping"); });
    $("#paint1-123").click(function(){ setpaint1("#3F3D14", "Jacquard"); });
    $("#paint1-124").click(function(){ setpaint1("#6F3241", "Damask"); });  
    $("#paint1-125").click(function(){ setpaint1("#4C4F58", "Denim"); });  
    
    $("#paint2-1").click(function(){ setpaint2("#B9A36B", "Sumatra"); });
    $("#paint2-2").click(function(){ setpaint2("#AC9C69", "Mocha"); });   
    $("#paint2-3").click(function(){ setpaint2("#82917B", "Steamer"); });
    $("#paint2-4").click(function(){ setpaint2("#8E8C5C", "Steamer"); });
    $("#paint2-5").click(function(){ setpaint2("#AA9D5C", "Hazelnut"); });
    $("#paint2-6").click(function(){ setpaint2("#DACEB6", "Capuccino"); });
    $("#paint2-7").click(function(){ setpaint2("#A1917F", "Bavarian"); });
    $("#paint2-8").click(function(){ setpaint2("#8C8D4A", "Green Tea"); });
    $("#paint2-9").click(function(){ setpaint2("#564422", "Cocoa"); });
    $("#paint2-10").click(function(){ setpaint2("#BAA872", "Medallion"); });
    $("#paint2-11").click(function(){ setpaint2("#FFF9C1", "Butter"); });
    $("#paint2-12").click(function(){ setpaint2("#F1EC9F", "Maple"); });
    $("#paint2-13").click(function(){ setpaint2("#E0CA73", "Honey"); });
    $("#paint2-14").click(function(){ setpaint2("#ECE399", "Bamboo"); });
    $("#paint2-15").click(function(){ setpaint2("#E6DB6B", "Manilla"); });
    $("#paint2-16").click(function(){ setpaint2("#C78F3F", "Teak"); });
    $("#paint2-17").click(function(){ setpaint2("#D3C17F", "Oak"); });
    $("#paint2-18").click(function(){ setpaint2("#E0BD62", "Straw"); });
    $("#paint2-19").click(function(){ setpaint2("#CA9C42", "Ale"); });
    $("#paint2-20").click(function(){ setpaint2("#E0BC4E", "Gold"); });
    $("#paint2-21").click(function(){ setpaint2("#F5EA95", "Birch"); });
    $("#paint2-22").click(function(){ setpaint2("#FFF696", "Cream"); });                
    $("#paint2-23").click(function(){ setpaint2("#829680", "Hosta"); });
    $("#paint2-24").click(function(){ setpaint2("#AEB196", "Moss"); });
    $("#paint2-25").click(function(){ setpaint2("#A9BB89", "Cypress"); });
    $("#paint2-26").click(function(){ setpaint2("#436152", "Spruce"); });
    $("#paint2-27").click(function(){ setpaint2("#476F56", "Fir"); });
    $("#paint2-28").click(function(){ setpaint2("#668461", "Juniper"); });
    $("#paint2-29").click(function(){ setpaint2("#526653", "Pine"); });
    $("#paint2-30").click(function(){ setpaint2("#D6E4C3", "Blade"); });
    $("#paint2-31").click(function(){ setpaint2("#DCE1C1", "Fescue"); });
    $("#paint2-32").click(function(){ setpaint2("#B8C49E", "Manzanita"); });
    $("#paint2-33").click(function(){ setpaint2("#8D2824", "Cayenne"); });
    $("#paint2-34").click(function(){ setpaint2("#803F32", "Ginger"); });
    $("#paint2-35").click(function(){ setpaint2("#73391E", "Spice"); });
    $("#paint2-36").click(function(){ setpaint2("#7D332D", "Paprika"); });
    $("#paint2-37").click(function(){ setpaint2("#6F2127", "Cabernet"); });
    $("#paint2-38").click(function(){ setpaint2("#602524", "Bordeaux"); });
    $("#paint2-39").click(function(){ setpaint2("#552A36", "Pinot"); });
    $("#paint2-40").click(function(){ setpaint2("#7F3C3E", "Merlot"); });
    $("#paint2-41").click(function(){ setpaint2("#6E4348", "Shiraz"); });
    $("#paint2-42").click(function(){ setpaint2("#752E21", "Sangria"); });
    $("#paint2-43").click(function(){ setpaint2("#9E2F34", "Saffron"); });
    $("#paint2-44").click(function(){ setpaint2("#AD4A3A", "Blush"); });    
    $("#paint2-45").click(function(){ setpaint2("#9F8D8E", "Twilight"); });
    $("#paint2-46").click(function(){ setpaint2("#A58F94", "Tempest"); });
    $("#paint2-47").click(function(){ setpaint2("#9F8C8F", "Thunder"); });
    $("#paint2-48").click(function(){ setpaint2("#6D4B5A", "Dusk"); });
    $("#paint2-49").click(function(){ setpaint2("#CBB3A1", "Mist"); });
    $("#paint2-50").click(function(){ setpaint2("#C2C6C6", "Fog"); });
    $("#paint2-51").click(function(){ setpaint2("#979CA3", "Rain"); });
    $("#paint2-52").click(function(){ setpaint2("#767A86", "Storm"); });
    $("#paint2-53").click(function(){ setpaint2("#E9E8EA", "Frost"); });
    $("#paint2-54").click(function(){ setpaint2("#DEDADC", "Wind"); });  
    $("#paint2-55").click(function(){ setpaint2("#E4E7E8", "Silver"); });  
    $("#paint2-56").click(function(){ setpaint2("#9897A4", "Skyline"); });     
    $("#paint2-57").click(function(){ setpaint2("#CCDCE4", "Blue"); });
    $("#paint2-58").click(function(){ setpaint2("#DCE3CC", "Reef"); });
    $("#paint2-59").click(function(){ setpaint2("#DEE7D5", "Breeze"); });
    $("#paint2-60").click(function(){ setpaint2("#BED0C2", "Reflection"); });
    $("#paint2-61").click(function(){ setpaint2("#648C80", "Foam"); });
    $("#paint2-62").click(function(){ setpaint2("#5C7A8C", "Coast"); });
    $("#paint2-63").click(function(){ setpaint2("#475B6F", "Cool"); });
    $("#paint2-64").click(function(){ setpaint2("#566688", "Tide"); });  
    $("#paint2-65").click(function(){ setpaint2("#6C7D99", "Swell"); });  
    $("#paint2-66").click(function(){ setpaint2("#8395B2", "Pool"); });       
    $("#paint2-67").click(function(){ setpaint2("#9BABBE", "Current"); });  
    $("#paint2-68").click(function(){ setpaint2("#B1BBC3", "Spray"); });       
    $("#paint2-69").click(function(){ setpaint2("#FFF1CA", "Bananas & Beans"); });
    $("#paint2-70").click(function(){ setpaint2("#C8F0D0", "Kiwis & Beans"); });
    $("#paint2-71").click(function(){ setpaint2("#B0D0E1", "Full o Beans"); });
    $("#paint2-72").click(function(){ setpaint2("#FFEAC4", "Peaches & Beans"); });
    $("#paint2-73").click(function(){ setpaint2("#FCD471", "Mango Tango Beans"); });
    $("#paint2-74").click(function(){ setpaint2("#8A5A8B", "Passion Fashion Beans"); });  
    $("#paint2-75").click(function(){ setpaint2("#373E61", "Black & Blue Beans"); });  
    $("#paint2-76").click(function(){ setpaint2("#EBD670", "Lemon Drop Beans"); });       
    $("#paint2-77").click(function(){ setpaint2("#94A74A", "Pistachio Lime Beans"); });  
    $("#paint2-78").click(function(){ setpaint2("#942F5C", "Berry Chili Beans"); });       
    $("#paint2-79").click(function(){ setpaint2("#FAD0D6", "Berries & Beans"); });
    $("#paint2-80").click(function(){ setpaint2("#EBC6F5", "Grapes & Beans"); });
    $("#paint2-81").click(function(){ setpaint2("#EAE3C6", "Ash"); });
    $("#paint2-82").click(function(){ setpaint2("#EBE8C7", "Feather"); });
    $("#paint2-83").click(function(){ setpaint2("#E5DFBF", "Stone"); });
    $("#paint2-84").click(function(){ setpaint2("#E8E0B9", "Pebble"); });
    $("#paint2-85").click(function(){ setpaint2("#F3F2DD", "Whip"); });
    $("#paint2-86").click(function(){ setpaint2("#EDE39C", "Sand"); });
    $("#paint2-87").click(function(){ setpaint2("#EFEAC2", "Custard"); });
    $("#paint2-88").click(function(){ setpaint2("#BABE9B", "Glass"); });
    $("#paint2-89").click(function(){ setpaint2("#EAE9BB", "Shell"); });
    $("#paint2-90").click(function(){ setpaint2("#EBE7CC", "Grain"); });
    $("#paint2-91").click(function(){ setpaint2("#ECF0CF", "Vanilla"); });
    $("#paint2-92").click(function(){ setpaint2("#F6F5F0", "Icing"); });  
    $("#paint2-93").click(function(){ setpaint2("#DBDBB5", "Crunch"); });
    $("#paint2-94").click(function(){ setpaint2("#C1C593", "Olive"); });
    $("#paint2-95").click(function(){ setpaint2("#D9B67C", "Cashew"); });
    $("#paint2-96").click(function(){ setpaint2("#B0BFA0", "Date"); });
    $("#paint2-97").click(function(){ setpaint2("#ADB8A8", "Almond"); });
    $("#paint2-98").click(function(){ setpaint2("#CAC08F", "Pecan"); });
    $("#paint2-99").click(function(){ setpaint2("#E3DFAF", "Macadamia"); });
    $("#paint2-100").click(function(){ setpaint2("#DCC47C", "Peanut"); });
    $("#paint2-101").click(function(){ setpaint2("#D7C185", "Filbert"); });
    $("#paint2-102").click(function(){ setpaint2("#D9CB80", "Oat"); });
    $("#paint2-103").click(function(){ setpaint2("#D2CEB3", "Ginseng"); });
    $("#paint2-104").click(function(){ setpaint2("#B86850", "Mesa"); });
    $("#paint2-105").click(function(){ setpaint2("#C48661", "Brick"); });
    $("#paint2-106").click(function(){ setpaint2("#F1C473", "Glow"); });
    $("#paint2-107").click(function(){ setpaint2("#BC5741", "Haze"); });
    $("#paint2-108").click(function(){ setpaint2("#B57843", "Dust"); });
    $("#paint2-109").click(function(){ setpaint2("#C78657", "Terracotta"); });
    $("#paint2-110").click(function(){ setpaint2("#E5BD7F", "Clay"); });
    $("#paint2-111").click(function(){ setpaint2("#E6D7AC", "Shimmer"); });
    $("#paint2-112").click(function(){ setpaint2("#D2BA7C", "Shade"); });
    $("#paint2-113").click(function(){ setpaint2("#C39B7C", "Canyon"); });
    $("#paint2-114").click(function(){ setpaint2("#D0C293", "Muslin"); });  
    $("#paint2-115").click(function(){ setpaint2("#8D3833", "Toile"); });
    $("#paint2-116").click(function(){ setpaint2("#667E5E", "Georgette"); });
    $("#paint2-117").click(function(){ setpaint2("#E3C474", "Organza"); });
    $("#paint2-118").click(function(){ setpaint2("#472C3B", "Shantung"); });
    $("#paint2-119").click(function(){ setpaint2("#444766", "Blue Silk"); });
    $("#paint2-120").click(function(){ setpaint2("#1B1612", "Leather"); });
    $("#paint2-121").click(function(){ setpaint2("#F4F3F1", "Pique"); });
    $("#paint2-122").click(function(){ setpaint2("#3C382D", "Piping"); });
    $("#paint2-123").click(function(){ setpaint2("#3F3D14", "Jacquard"); });
    $("#paint2-124").click(function(){ setpaint2("#6F3241", "Damask"); });  
    $("#paint2-125").click(function(){ setpaint2("#4C4F58", "Denim"); });  

});   

