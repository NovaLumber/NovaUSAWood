//TODO:  Requires Refactor and Peer Review

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
    var returnVar;
    if (document.getElementById)
        returnVar = document.getElementById(id);
    else if (document.all)
        returnVar = document.all[id];
    else if (document.layers)
        returnVar = document.layers[id];
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
function showCartDiv(guid) {
    OpenDiv('CartView');
    UpdateCart('CartView',guid); 
    return false;
}
function calcNeeds() {
    var boxCount;
    var totalSF;
    var totalCost;
    var partBox;
    var sfPerSub;
    var webPrice;
    var sfRequired;
    
    CloseDiv('CartView');
    
    sfPerSub = document.getElementById("sfPerSub").value;
    webPrice = document.getElementById("webPrice").value;
    
    var value = document.getElementById("ctl00_Content_sfRequired").value;
    
    sfRequired = parseInt(value);

    partBox = sfPerSub / 2;
    boxCount = sfRequired / sfPerSub + 0.5;
    boxCount = Math.round(boxCount);
    totalSF = Math.round(sfPerSub * boxCount);

    //need to add the discount rate if applicable from customer table
    totalCost = totalSF * webPrice;

    document.getElementById("ctl00_Content_calcResult1").value = boxCount;
    document.getElementById("ctl00_Content_calcResult2").value = totalSF;
    document.getElementById("ctl00_Content_calcResult3").value = formatCurrency(totalCost);
}
function formatCurrency(num) {
    num = num.toString().replace(/\$|\,/g,'');
    if(isNaN(num))
    num = "0";
    sign = (num == (num = Math.abs(num)));
    num = Math.floor(num*100+0.50000000001);
    cents = num%100;
    num = Math.floor(num/100).toString();
    if(cents<10)
    cents = "0" + cents;
    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
    num = num.substring(0,num.length-(4*i+3))+','+
    num.substring(num.length-(4*i+3));
    return (((sign)?'':'-') + '$' + num + '.' + cents);
}