$(document).ready(function (){

	//anchor animation
	$('a.anchor-jumper').click(function(){
	    $('html, body').animate({
	        scrollTop: $( $.attr(this, 'href') ).offset().top
	    }, 800);
	    return false;
	});

	//youtube overlap IE
	$('iframe').each(function(){
	  	var url = $(this).attr("src");
	  	$(this).attr("src",url+"?wmode=transparent");
	});

	//footer responsive collapse
	if ($(window).width() <= 768){  
		$('#footer .nav-container ul').removeClass('in');
	}

	//page height adjust when less content
    if ($('.wrapper').height() < $( window ).height()) {
      $('.wrapper .bg-grey-2').css("padding-bottom", "17vh");
    }

});

