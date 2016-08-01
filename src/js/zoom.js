$(function() {
    var win = require('nw.gui').Window.get();
    var zoomin = $('#zoom_in');
    var zoomout = $('#zoom_out');

    zoomin.click(function() {
        win.zoomLevel += 0.2;
        localStorage.setItem('zoom', win.zoomLevel);
    });

    zoomout.click(function() {
        win.zoomLevel -= 0.2;
        localStorage.setItem('zoom', win.zoomLevel);
    });

    /* Seteo el zoom de acuerdo a si ya lo habían cambiado */
    win.zoomLevel = localStorage.getItem('zoom') || 0;
});
