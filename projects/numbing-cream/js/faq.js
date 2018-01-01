function eventFire(el, etype){
  if (el.fireEvent) {
    el.fireEvent('on' + etype);
  } else {
    var evObj = document.createEvent('Events');
    evObj.initEvent(etype, true, false);
    el.dispatchEvent(evObj);
  }
}

$(document).ready(function (){
			
	function getURLParameter(name) {
	  	return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null
	}		

	var an = getURLParameter('a');

	if (an == "refund") {
		document.getElementById('infoRefund').click();
		//eventFire(document.getElementById('infoRefund'), 'click');
	}

	$('.collapse a').click(function (e) {
		$('.active').removeClass('active');
	})


	//mobile
	if ($(window).width() <= 768){  
		$('.side-nav').removeClass('in');
	}
});