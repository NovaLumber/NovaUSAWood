function OpenDiv(ID)
{
    returnObjById(ID).style.display= "block"; 
}
function CloseDiv(ID)
{
    returnObjById(ID).style.display= "none"; 
}
function returnObjById( id )
{
    if (document.getElementById)
        var returnVar = document.getElementById(id);
    else if (document.all)
        var returnVar = document.all[id];
    else if (document.layers)
        var returnVar = document.layers[id];
    return returnVar;
}
function UpdateCart(ID,Guid){
 
    var ViewCart = returnObjById(ID);
	var ajaxRequest;  // The variable that makes Ajax possible!
	
	try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	} catch (e){
		// Internet Explorer Browsers
		try{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e){
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}
	ajaxRequest.onreadystatechange = function(){
	    if(ajaxRequest.readyState == 4){
	        returnObjById(ID).innerHTML = ajaxRequest.responseText;
	    }
    }
    ajaxRequest.open("GET", "ShoppingCart.aspx?Guid="+Guid, true);
    ajaxRequest.send(null); 
}
function formHandler(form){
    var URL = form.options[form.selectedIndex].value;
    window.location.href = URL;
}
function updateImage(new_url,index,isSuper) {
 	document['PhotoBig'].src = new_url;	
}