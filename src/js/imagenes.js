$(document).ready(function() {
	$('.image').magnificPopup({
  	type:'image',
  	callbacks: {
   		elementParse: function(item) {

        /* Si la ruta de la imagen parece un thumbnail, entonces intenta
         * abrir un popup con la imagen en escala real (no la miniatura).
         */
        if (item.el.children()[0].src.indexOf('thumb') > -1)
          item.src = (item.el.children()[0].src).replace('thumb/', '').replace(/\/\d+px.*/mg, '')
        else 
          item.src = item.el.children()[0].src;

    	}
  	}
	});
});
