function optimize() {
	var margin = ($(window).height() - $('#main').height() - 15 - 8 - $('#footer').height()) / 2;
	$('#main').css('margin-top', margin).css('margin-bottom', margin);
	var marginxs = ($(window).height() - $('#main-xs').height() - 15 - 8 - $('#footer').height()) / 2;
	$('#main-xs').css('margin-top', marginxs).css('margin-bottom', marginxs);
	$('#preload').hide(function(){
		$('div').css('opacity', 1);
	});
};
