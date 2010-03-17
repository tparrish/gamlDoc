$(document).ready(function(){
	
	if(window.location.protocol != 'file:') {
		//Can't do this AJAX stuff if we're running from the local filesystem
	
		$('.binding_tooltip').each(function(){
			if($(this).attr('name')) {
				theUrl = "../summaries/"+$(this).attr('name')+".html";
			}
			else {
				theUrl = "../summaries/"+$(this).parent().attr('title')+".html";
			}
			$(this).qtip({
				content : {
					url: theUrl
				},
				show: 'mouseover',
				hide: 'mouseout',
				style: {
					tip: 'bottomLeft',
			      	border: {
				         width: 3,
				         radius: 8
				      }
				},   
				position: {
					corner: {
			       		target: 'topRight',
			        	tooltip: 'bottomLeft'
			      	}
			   }
			});
		});
	}
	
	$('#events .attributes dl di').bind('mouseout', function() {
		$(this).removeClass('selected')		
	});
	
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