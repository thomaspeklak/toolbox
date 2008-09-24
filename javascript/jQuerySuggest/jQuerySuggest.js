(function($){
	$.suggest = function(term){
		if($.suggest.timer) {
			clearTimeout($.suggest.timer);}
		list = [];
		reg = new RegExp('^'+term,'i');
		for(i=0,j=terms.length;i<j;i++){
			if(reg.exec(terms[i])) list.push(terms[i]);}
		o="<ul>";
		for(i=0,j=list.length;i<j;i++){
			o+='<li>'+list[i]+'</li>';}
		$('#suggest').html(o+'</ul>');
		$('#suggest ul li:first').addClass('selected');
		$('#suggest').show();
		$('#suggest li').mouseover(function(){
			$('#suggest li.selected').removeClass('selected');
			$(this).addClass('selected');
		})
		$('#suggest li').click(function(){
			$('#suggest').hide();
			$('#suggest').html('');
		});
		$.suggest.timer = setTimeout(function(){select_rest();},$.suggest.timeout);
	}
	$.suggest.timeout = 300;
	
	function select_rest(){
		var len=$.suggest.input.value.length;
		if($.suggest.suggestions.firstChild && $.suggest.suggestions.firstChild.firstChild){
			$.suggest.input.value=$.suggest.suggestions.firstChild.firstChild.firstChild.nodeValue;
			if($.suggest.input.createTextRange){
					var oRange = $.suggest.input.createTextRange();
					oRange.moveStart("character", len);
					oRange.moveEnd("character", $.suggest.input.value.length);
					oRange.select();
					$.suggest.input.focus();
			}
			else{
				$.suggest.input.setSelectionRange(len,$.suggest.input.value.length);
			}
		}
	}
	
	
	$(function(){
		$('#searchInput').keyup(function(oEvent){
			var iKeyCode = oEvent.keyCode;
			if (iKeyCode < 32 || (iKeyCode >= 33 && iKeyCode <= 46) || (iKeyCode >= 112 && iKeyCode <= 123)) {
			switch (iKeyCode){
				case 40: //down
					var obj=$('#suggest .selected').get(0);
					if(obj.nextSibling){
						$(obj.nextSibling).addClass('selected');
						$(obj).removeClass('selected');
						this.value=obj.nextSibling.firstChild.nodeValue;}
					break;
				case 38: //up
					var obj=$('#suggest .selected').get(0);
					if(obj.previousSibling){
						$(obj.previousSibling).addClass('selected');
						$(obj).removeClass('selected');
						this.value=obj.previousSibling.firstChild.nodeValue;}
					break;
				case 8: //backspace
					if(this.value){$.suggest(this.value);}
					else{$('#suggest').hide();}
					break;
				case 46: //delete
					if(this.value){$.suggest(this.value);}
					else{$('#suggest').hide();}
					break;
				case 13: //enter
					actSearch=this.value;
					$('#suggest').hide();
					$('#suggest').html('');
					$('#searchInput').get(0).value=$('#searchInput').get(0).value;
					document.location.href='#'+getId(this.value);
					break;
				case 27: //esc
					$('#suggest').hide();
					$('#suggest').html('');
					break;
				}
			 }
			 else{
			if(this.value && this.value!=' '){
				$.suggest(this.value);}
			else{$('#suggest').hide();}}
		});
		$('input').blur(function(){setTimeout("$('#suggest').hide();",200)});
		$.suggest.suggestions=$('#suggest')[0];
		$.suggest.input=$('#searchInput')[0];
});
	
})(jQuery);