// JScript File


function CreateIEFlash(ID, Movie, Width, Height, BGC,
Play, Loop, Qual)
{
 var clsid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000";
 var codebase="http://download.macromedia.com/pub/";
 codebase+="shockwave/cabs/flash/swflash.cab";
 codebase+="#version=6,0,40,0";
 document.write('<object classid="' + clsid + '" ');
 document.write('codebase="'+ codebase + '" ');
 if (Width>0)
  document.write('width="'+ Width + '" '); 
 if (Height>0)
  document.write('height="' + Height + '" ');
 document.write('id="' + ID + '">');
 document.write('<param name="movie" value="'+ Movie + '"');
 if (Qual.length>0)
  document.write('<param name="quality" value="'+Qual+'">');
 if (BGC.length>0) 
  document.write('<param name="bgcolor" value="'+ BGC +'>');
 document.write('<param name="loop" value="' + Loop + '">');
 document.write('<param name="play" value="'+ Play +'">');
 document.write('</object>');
}

function CreateIEFlash2(Div, Movie, Width, Height, BGColor, Loop)
{
    var myObject = document.createElement('object');
    Div.appendChild(myObject);
    myObject.width = Width;
    myObject.height = Height;
    myObject.classid = "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"; 
    myObject.codebase = "http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0";
    myObject.movie = Movie;
    myObject.bgcolor = BGColor;
    myObject.Loop = Loop;
    myObject.Play = false;
}


function CreateAltFlash(Div, Movie, Width, Height, BGColor, Loop, Quality)
{
    //doesn't seem to work in Firefox...
    //document.write('<object type=application/x-shockwave-flash loop=' + Loop + ' data=' + Movie + ' width=' + Width + ' height=' + Height + ' quality=' + Quality + '/>');
    //document.write('<object type="application/x-shockwave-flash" loop="true" data="flash_crystals.swf" width="400" height="300" play="true" menu="true" quality="best" />');

}

