(function() {
    var app = require('nw.gui').App;

    function parseCmdline(cmdline) {
        /* El primer parametro es el binario de nwjs, el segundo la app y de ahi en mas los del visor */
        return cmdline.split(' ')[2];
    }

    function getWikipage(wikipage) {
        if(wikipage === undefined) {
            return 'app://./documentacion/index.html';
        } else if(wikipage.startsWith('/articles')) {
            return 'app://./documentacion' + wikipage;
        } else {
            /* TODO: intentar cargar la wikipage por su nombre (o lanzar el buscador) */
            return 'app://./documentacion/index.html';
        }
    }

    /* Navego hacia una url solo si es necesario */
    function navigateTo(url) {
        if(window.location.href != url) {
            window.location.href = url;
        }
    }

    app.on('open', function(cmdline) {
        navigateTo(getWikipage(parseCmdline(cmdline)));
    });

    /* Al ejecutarse por primera vez no levanta el evento de 'open' */
    process.mainModule.exports.onInit(function() {
        navigateTo(getWikipage(app.argv[0]));
    });
})();