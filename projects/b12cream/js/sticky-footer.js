var bodyHeight = $("body").height();
var vwptHeight = $(window).height();
if (vwptHeight > bodyHeight) {
	$('.footer').attr('id', 'stickyFooter');
	$("#stickyFooter").css("position","absolute").css("bottom",0);
}