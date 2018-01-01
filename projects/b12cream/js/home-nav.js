
var fixmeTop = $('.fixme').offset().top;    
$(window).scroll(function() {                  
		var currentScroll = $(window).scrollTop(); 
	if (currentScroll >= fixmeTop) {          
        $('.fixme').css({   
        	width: '100%',                   
	        position: 'fixed',
	        top: '0',
	        left: '0',
	        'z-index': '20'
		});
	} else {                                   
		$('.fixme').css({                      
    		position: 'static'
		});
		}
});