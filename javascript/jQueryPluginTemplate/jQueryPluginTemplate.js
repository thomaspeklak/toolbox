(function($){
	$.fn.plugin = function(options){
		//initialize defaults
		var defaults = {
			}
		//override them with options
		var opts = $.extend(defaults, options);

		//iterate over elements
		return this.each(function(){
				
		});
	};
	
	//public method
	$.fn.plugin.method = function(txt) {
    return null;
  };
	
	//private method
	function closure_method(target){

	};
})(jQuery);