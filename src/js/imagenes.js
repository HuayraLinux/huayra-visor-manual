$(document).ready(function() {
	$('.image').magnificPopup({
  	type:'image',
  	callbacks: {
   		elementParse: function(item) {
        item.src = item.el.children()[0].src;
    	}
  	}
	});
});