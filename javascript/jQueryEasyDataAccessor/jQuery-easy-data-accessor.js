/* Easy data accessor with jQuery
 *
 * source: http://yehudakatz.com/2009/04/20/evented-programming-with-jquery/
 *
 * instead of $("#foo").data("foo") or $("#foo").data("foo", "bar")
 * you can do $.DA("#foo").foo and $.DA("#foo").foo = bar
 * or icrement a value $.DA("#foo").foo++
 */

(function($){
  $.DA = function(param) {
    var node = $(param)[0];
    var id = $.data(node);
    $.cache[id] = $.cache[id] || {};
    $.cache[id].node = node;
    return $.cache[id];
  };
})(jQuery);