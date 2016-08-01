$(function() {
    var shell = require('nw.gui').Shell;
	$('.external').click(function() {
        shell.openExternal(this.href);
        return false;
	})
});