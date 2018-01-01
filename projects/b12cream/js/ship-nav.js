function showOption(place, el) {
	var options = document.getElementsByClassName("option-location");
	for (var i=0; i<options.length; i++) {
	  options[i].style.display = 'none';
	}
	document.getElementById(place).style.display="block";

	var optionBtn = document.getElementsByClassName("option-button");
	for (var i=0; i<options.length; i++) {
	  optionBtn[i].style.background = 'rgba(30, 30, 30, 1)';
	}
	el.style.background = 'white'
}

var fixmeTop = $('.fixme').offset().top;    

$(window).scroll(function() {                  

		var currentScroll = $(window).scrollTop(); 

	if (currentScroll >= fixmeTop) {          
        $('.fixme').css({   
        	width: '100%',                   
	        position: 'fixed',
	        top: '0',
	        left: '0',
	        'z-index': '20',
	        'background-color': 'rgba(250, 62, 82, 1)'
		});
	} else {                                   
		$('.fixme').css({                      
    		position: 'static'
		});
		}

});