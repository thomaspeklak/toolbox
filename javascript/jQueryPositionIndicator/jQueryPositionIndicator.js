(function($){
	$.browser.msieLt7=($.browser.msie && $.browser.version<7)?1:0;
	$.positionIndicator = {
		storeHeadingPositions : function(){
			$.positionIndicator.storedPositions = [];
			$('h1,h2').each(function(){
				$.positionIndicator.storedPositions.push([this.offsetTop,$(this).text()]);
			});
			$.positionIndicator.storedPositions.reverse();
		},
		currentHeading : function(){
			var fromTop=($.browser.msieLt7)?document.body.scrollTop-50:document.documentElement.scrollTop;
			for(var i in $.positionIndicator.storedPositions){
				if($.positionIndicator.storedPositions[i][0]<fromTop+80) return $.positionIndicator.storedPositions[i][1];
			}
			return $.positionIndicator.storedPositions[i][1];
		},
		setIEDisplayProperties : function(){
			$('#positionIndicator').css('right',document.body.offsetWidth-document.body.clientWidth);
		},
		showCurrent : function(){
			$('#positionIndicator').html($.positionIndicator.currentHeading()).fadeIn();
		}
	}
	$(function(){
		$.positionIndicator.storeHeadingPositions();
		if(!$.browser.msieLt7){
			$('body').append('<div id="positionIndicator"></div>');
			$(window).scroll(function(){
				$.positionIndicator.showCurrent();
			});
		}
		else{
			$('#content').append('<div id="positionIndicator"></div>');
			$('body').scroll(function(){
				$.positionIndicator.showCurrent();
			});
			$(window).resize(function(){
				$.positionIndicator.setIEDisplayProperties();
			});
			$.positionIndicator.setIEDisplayProperties();
		}
		$(window).resize(function(){$.positionIndicator.storeHeadingPositions();});
	});
})(jQuery);