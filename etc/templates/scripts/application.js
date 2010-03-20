$(document).ready(function(){
		
	
	// Hide all the descriptions that are on the page
	$('.binding_tooltip + span.description').hide();

	$('.binding_tooltip').each(function(){
		
		if($(this).next('span.description').html()) {
			description = $(this).next('span.description').html();
		}
		else {
			description = undefined;
		}
		
		if(window.location.protocol == 'file:') {
			//Can't do this AJAX stuff if we're running from the local filesystem
			content = description;			
		}
		else {
			if($(this).attr('name')) {
				theUrl = "../summaries/"+$(this).attr('name')+".html";
			}
			else {
				theUrl = "../summaries/"+$(this).parent().attr('title')+".html";
			}
			content = {
				title: description,
				url: theUrl
			}
		}		
		
		if(content) {
			$(this).qtip({
				content : content,
				show: 'mouseover',
				hide: 'mouseout',
				style: {
					tip: 'leftMiddle',
			      	border: {
				         width: 3,
				         radius: 8
				    },
					title: {
						'background-color': 'white',
						'font-weight': 'normal'
					}
				},   
				position: {
					corner: {
			       		target: 'rightMiddle',
			        	tooltip: 'leftMiddle' 
			      	}
			   }
			});
		}
	});
	
	// Do some shit to allow code examples to degrade gracefully
	$('div.example code').each(function() {
		$(this).replaceWith("<script type=\"syntaxhighlighter\" class=\"brush: xml\"><![CDATA["+$(this).html()+"]]></script>");
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