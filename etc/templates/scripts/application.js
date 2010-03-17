$(document).ready(function(){
	
	$('#events .attributes dl di').bind('mouseover', function() {
		$(this).addClass('selected')
	});
	
	$('#events .attributes dl di').bind('mouseout', function() {
		$(this).removeClass('selected')		
	});
	
	// Make the menu frame slide in and out
	// $('#menu-frame .handle').toggle(function() {
	// 	$('#menu-frame .content').fadeOut();
	// 	return false;
	// },
	// function(){
	// 	$('#menu-frame .content').fadeIn();
	// 	return false;
	// });
	
	$('.togglable').hide();
	
	//Make a button toggle whether
	$('.togglable_control').toggle(function(){
		block = $(this).attr('href')
		$(block).fadeIn();
	},
	function(){
		block = $(this).attr('href')
		$(block).fadeOut();
	});
});