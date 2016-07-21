$(function() {
    var win = require('nw.gui').Window.get();
    var zoomin = $('#zoom_in');
    var zoomout = $('#zoom_out');

    zoomin.click(function() {
        win.zoomLevel += 0.2;
        global.zoomLevel += 0.2
    });

    zoomout.click(function() {
        win.zoomLevel -= 0.2;
        global.zoomLevel -= 0.2
    });

    /* Seteo el zoom de acuerdo a si ya lo habían cambiado */
    global.zoomLevel = global.zoomLevel || 0;
    win.zoomLevel = global.zoomLevel || 0;
});
