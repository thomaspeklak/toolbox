/*
 * jQuery.textHighlight
 */
(function($){
	// extend the jQuery selector engine
	$.expr[':'].containsIgnoreCase = '(a.textContent||a.innerText||jQuery(a).text()||"").toLowerCase().indexOf(m[3].toLowerCase())>=0';
	
	$.highlights = {
		//cache highlighted texts
		texts: [],
		//search for texts to highlight
		search: function(term) {
			var term = term.toLowerCase();
			var termRegex = new RegExp(term,'ig');
			$('#content :containsIgnoreCase("'+term+'")').not('script').each(function(){
				var childs = this.childNodes;
				for(c in childs){
					var child = childs[c];
					if(child.nodeType==3){
						if(child.nodeValue.toLowerCase().indexOf(term)>=0){
							$.highlights.place(term, child, termRegex);
						}
					}
				}
			});
		},
		//place the highlight spans
		place: function(term, node, termRegex){
			var val = node.nodeValue;
			var matches = val.match(termRegex);
			var textfragments = val.split(termRegex);
			var fragment = null;
			var parent = node.parentNode;
			var nextNode = node.nextSibling;
			if(!$.browser.msie || (matches.index!==0)) fragment = textfragments.shift();
			node.nodeValue = (fragment)?fragment:'';
			while(matches.length){
				fragment = textfragments.shift();
				var newNode = $.highlights.span.cloneNode(true);
				newNode.appendChild(document.createTextNode(matches.shift()));
				$.highlights.texts.push(newNode);
				if(nextNode){
					parent.insertBefore(newNode, nextNode);
					if(fragment) parent.insertBefore(document.createTextNode(fragment), nextNode);
				}
				else{
					parent.appendChild(newNode);
					if(fragment) parent.appendChild(document.createTextNode(fragment));
				}
			}
		},
		//find the terms to highlight through the document.location
		// e.g. test.html?highlight=test;more,evenmore
		highlightTerms: function(){
			var query = document.location.search.split('=');
			if(query.length>1){
				var searchTerms = decodeURI(query[1]).split(';');
				for (t in searchTerms){
					$.highlights.search(searchTerms[t]);
				}
			}
			$.highlights.initialized = true;
			$.highlights.visible = true;
		},
		//toggle the highlights on/off
		toggle: function(){
			if($.highlights.initialized){
				for(var i=0,l=$.highlights.texts.length;i<l;i++){
					$($.highlights.texts[i]).toggleClass('highlight').toggleClass('noHighlight');}
			}
			else{$.highlights.highlightTerms();}
		},
		//initialize
		//create an emtpy span for reuse/cloning
		init: function(){
			$.highlights.span = $('<span class="highlight"></span>')[0];
		},
		initialized: false,
		visible: false
	}
	$.highlights.init();
	$(function(){$.highlights.highlightTerms();});
})(jQuery);