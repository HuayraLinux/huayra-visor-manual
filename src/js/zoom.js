$(function() {
    var win = require('nw.gui').Window.get();
    var input = $('#zoom');

    input.change(function() {
        win.zoomLevel = input.val();
    });
});