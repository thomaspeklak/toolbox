(function($){
	$.liveQuery = {
		text: '',
		shownRows: {},
		hiddenRows: {},
		shownContent: {},
		hiddenContent: {}
	};
	$.fn.liveQuery = function(list){
		list = $(list);
		if(list.length){
			$.liveQuery.shownRows = list.children('li');
			$.liveQuery.shownContent = $.liveQuery.shownRows.map(function(){return this.innerHTML.toLowerCase();});
			this.keyup($.liveQuery.handleInput).parents('form').submit(function(){return false;});
		}
		return this;
	};
	$.liveQuery.handleInput = function (){
		if(typeof($.liveQuery.active)=='number') clearTimeout($.liveQuery.active);
		$('#spinner').css('display','inline');
		$.liveQuery.active=setTimeout('$.liveQuery.filter("'+jQuery.trim(jQuery(this).val().toLowerCase())+'")',400);
	};
	$.liveQuery.filter = function (term){
		if (term.length>1){
			if(term.search($.liveQuery.text)!=-1){
				moveToHidden();
			}
			else{
				moveToShown(0);
				moveToHidden();
			}
		}
		else{
			moveToShown(1);
		}
		$.liveQuery.text = term;
		$('#spinner').css('display','none');

		function moveToHidden(){
			$.each($.liveQuery.shownContent,function(i){
				if($.liveQuery.shownContent[i] && $.liveQuery.shownContent[i].search(term) == -1){
					$.liveQuery.hiddenRows[i]=$.liveQuery.shownRows[i];
					$.liveQuery.hiddenContent[i]=$.liveQuery.shownContent[i];
					$($.liveQuery.shownRows[i]).addClass('hide');
					delete $.liveQuery.shownRows[i];
					delete $.liveQuery.shownContent[i];
				}
			});
		}
		function moveToShown(force){
			$.each($.liveQuery.hiddenContent,function(i){
				if(force || ($.liveQuery.hiddenContent[i] && $.liveQuery.hiddenContent[i].search(term) != -1)){
					$.liveQuery.shownRows[i]=$.liveQuery.hiddenRows[i];
					$.liveQuery.shownContent[i]=$.liveQuery.hiddenContent[i];
					$($.liveQuery.hiddenRows[i]).removeClass('hide');
					delete $.liveQuery.hiddenRows[i];
					delete $.liveQuery.hiddenContent[i];
				}
			});	
		}
	}
})(jQuery);