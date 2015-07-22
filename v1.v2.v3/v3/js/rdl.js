function downloadFile(url)  
{   
	try
	{ 
		var elemIF = document.createElement("iframe");   
		elemIF.src = url;   
		elemIF.style.display = "none";   
		document.body.appendChild(elemIF);   
	}catch(e){ 

	} 
}  
