$(document).ready(function () {
	$("#owlCart").owlCarousel({
		items : 1,
		itemsDesktop : [1200,1],
    	itemsDesktopSmall : [979,1],
    	itemsTablet : [768,1],
    	itemsTabletSmall : [479,1],
	});

	$('.cart-jumper').click(function (e) {
		$(".cart-bill table tr").removeClass("highlight");
		$(this).parent().parent().addClass("highlight");


		var target = $(this).attr('title');
		$("#"+target).addClass("owl-highlight");
		setTimeout(function() {
			$("#"+target).removeClass("owl-highlight");
		 }, 2500);

		var target_index = $("#"+target).parent().parent().index();
		var owl = $("#owlCart").data('owlCarousel');
		owl.goTo(target_index);
	});
});