(function($){
	$.fn.pageStreamer = function(options){
		//initialize defaults
		var defaults = {
			offsetBottom: 		800,
			query:						document.location.href,
			startpage:				1,
			indexName:				'page',
			indexIncrement:		1,
			loadingIndicator:	'loadingIndicator',
			loadingText:			'Loading more results ...',
			callback:					function(data){$('body').append(data);}
			}
		//override them with options
		var opts = $.extend(defaults, options);
		var currentPage = opts.startpage;
		var queryIndexName = opts.indexName + "=";
		var queryRegEx = new RegExp('[?&]'+queryIndexName);
		var queryReplace = new RegExp(queryIndexName +'[0-9]*[;]*');
		if(queryRegEx.test(opts.query)){
			opts.query.replace(queryReplace,'');}
		
		//bind scroll event to each element 
		this.stream = function(){
			this.each(function(){
				stream(this);
			});
		}
		
		//bind the scroll event to target
		function stream(target){
			$(target).scroll(function(){streamData(target)})
		}
		
		//initialize
		this.stream();
		
		//load data if scrolled to bottom
		function streamData(target){
			//check if we are near the bottom of a page
			if(
				//if the scroll event bound to the window we need to retrieve other values than if it is bound to a scrollable element
				(target==window && (
					(window.scrollY && (window.scrollY > window.scrollMaxY - opts.offsetBottom)) ||
					($.browser.msie && (document.documentElement.scrollTop > document.documentElement.scrollHeight - opts.offsetBottom))
				)) ||
				(target.scrollTop + target.offsetHeight > target.scrollHeight - opts.offsetBottom)){
				
				//tell the user that we are currently loading data and do not retrieve new data (unbind scroll event)
				$(target).unbind('scroll').append('<div id="'+ opts.loadingIndicator +'"><strong>'+ opts.loadingText +'</strong></p>');
				
				//load data and invoke callback
				$.get(opts.query, {page: currentPage++},
					function(data){
						$('#'+ opts.loadingIndicator).remove();
						opts.callback(data)
						stream(target);
					}
				);
			}
		}
	}
})(jQuery);