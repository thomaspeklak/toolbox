(function($){
	/* shows an info box with contents of the title attribute of selected elemens
	 * usage:
	 *    $(selector).infoBox(options)
	 */
	$.fn.infoBox = function(options){
		//initialize defaults
		var defaults = {
			infoTimer: 	0,
			showTime:		10000,
			target:			'#info',
			offset:			[2,-2]}
		//override them with options
		var opts = $.extend(defaults, options);
		
		//create target if it is not already existent
		if($(opts.target).length==0){
			createTarget();}
		
		//create events on matched elements
		return this.each(function(){
			if(this.title){
				$(this).mouseover(show).mousemove(move).mouseout(hide);			
			}
		});
		
		//show the info box
		function show(){
			$(opts.target).text(this.title).stop().fadeTo('fast',1);
			this.tempTitle = this.title;
			this.title = '';
			}
			
		//track cursor movement
		function move(e){
			clearTimeout(opts.infoTimer);
			var posx = 0,posy = 0;
			if (!e) var e = window.event;
			if (e.pageX && e.pageY){
				posx = e.pageX;
				posy = e.pageY;
			}
			else if (e.clientX && e.clientY){
				posx = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
				posy = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
			}
			$(opts.target).css({top:posy+opts.offset[0]+'px',left:posx+opts.offset[1]+'px'});
			opts.infoTimer=setTimeout(hide,opts.showTime);
			}
		
		//hide info box
		function hide(){
			$(opts.target).stop().fadeTo('fast',0);
			this.title = this.tempTitle;
			}
			
		//create the info box target
		function createTarget(){
			$('body').append($('<div id="'+ opts.target.replace(/^#/,'') +'"> </div>').css('opacity',0));
		}
	}
})(jQuery);
