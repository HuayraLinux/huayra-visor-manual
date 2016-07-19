$(function() {
    var win = require('nw.gui').Window.get();
    var input = $('#zoom');

    input.change(function() {
        win.zoomLevel = input.val();
        global.zoomLevel = input.val();
    });

    /* Seteo el zoom de acuerdo a si ya lo habían cambiado */
    input.val(global.zoomLevel || 0);
    /* input.val no tira el evento */
    input.change();
});
