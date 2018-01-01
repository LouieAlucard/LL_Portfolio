$( document ).ready(function() {
	$('.sale-price a').click(function (e) {
		e.preventDefault();
	    var target_pane = $(this).attr('href');
	    if($(this).parent('li').hasClass('active')){
        	$( target_pane ).hide('500');
	        $(this).parent('li').removeClass('active');
	        event.stopImmediatePropagation();
	    } else {
	    	$( target_pane ).parent('.tab-content').children( '.tab-pane' ).hide();
        	$( target_pane ).show('500');
	    }
	});

	//usage image group
	var usageClick = false;
	
	//click text
	$('#contentUsage a').click(function (e) {
		usageClick = true;
		e.preventDefault();
		$('[id^="usage0"]').removeClass('highlight');
		$('#contentUsage a').removeClass('highlight');
	    var target_img=$(this).attr('href');
	    $( target_img ).addClass('highlight');
	    $(this).addClass('highlight');
	});

	//click image
	$('[id^="usage0"]').click(function (e) {
		usageClick = true;
		var clicked = $(this).attr('id');
		clicked = parseInt(clicked.substr(clicked.length - 1))
		var clicked_text = $('#contentUsage li:eq('+ clicked +') a');

		$('[id^="usage0"]').removeClass('highlight');
		$('#contentUsage a').removeClass('highlight');
	    clicked_text.addClass('highlight');
	    $(this).addClass('highlight');
	});

	//self navigation
	setInterval( function highlighting() {
		if (usageClick == false) {
			var current = $('[id^="usage0"].highlight').attr('id');
			var next = parseInt(current.substr(current.length - 1)) + 1;
			if (next == 9) {
				next = 0;
			}
			var e = $('#contentUsage li:eq('+ next +') a');
			var next_img = e.attr('href');

			$('[id^="usage0"]').removeClass('highlight');
			$('#contentUsage a').removeClass('highlight');
		    $( next_img ).addClass('highlight');
		    e.addClass('highlight');
		} else {
			usageClick = false;
		}
    }, 6000);
})    