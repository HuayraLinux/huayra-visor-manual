(function() {
    var app = require('nw.gui').App;
    var exists = require('fs').existsSync;

    /* HACKY: Al ejecutarse por primera vez no levanta el evento de 'open' */
    process.mainModule.exports.onInit(function() {
        /* Antes de cualquier cosa joineo los argumentos al string de título */
        navigateTo(getWikipage(app.argv.join(' ')));
    });

    app.on('open', onOpen);

    function onOpen(cmdline) {
        navigateTo(getWikipage(parseCmdline(cmdline)));
    }

    /* Quito el listener para no stackear los windows descartados de la closure */
    window.onunload = function() {
        app.removeListener('open', onOpen);
    };

    function getWikipage(wikipage) {
        if(wikipage === undefined || wikipage === '') {
            return 'app://./documentacion/index.html';
        } else if(wikipage.startsWith('/articles')) {
            return 'app://./documentacion' + wikipage;
        } else {
            var wikipath = getDirectory(wikipage);

            if(exists(wikipath)) {
                return 'app://./' + wikipath;
            }
            /* Si no existe la página lo mando al index por perejil
             * TODO: Mandarlo a la página de búsqueda
             */
            console.warn("No se pudo encontrar", wikipath);
            return 'app://./documentacion/index.html';
        }
    }

    /* Navego hacia una url solo si es necesario */
    function navigateTo(url) {
        if(window.location.href != url) {
            window.location.href = url;
        }
    }

    function parseCmdline(cmdline) {
        /* El primer parametro es el binario de nwjs, el segundo la app y de ahi en mas los del visor
         * Los vuelvo a unir a un string porque el único parámetro posible es la página
         */
        return cmdline.split(' ').splice(2).join(' ');
    }

    function getDirectory(title) {
        return 'documentacion/articles/' + firstLetters(title) + mediawikiUrlify(title) + '.html';
    }

    function firstLetters(title) {
        /* Si el título es algo tipo 2.0:Accesibilidad la parte anterior al ':' no cuenta
         *     Nota: indexOf devuelve -1 si no encuentra algo y slice devuelve la cadena A PARTIR del índice dado
         */
        var title = title.slice(title.indexOf(':') + 1); /* Le quito un prefijo si lo tiene */
        var regex = /(.)(.)?(.)?/

        /* Matcheo la expresión regular */
        return regex.exec(title)
                    /* El primer match no forma parte de los capturing groups */
                    .splice(1)
                    /* MediaWiki-extension-dumpHTML escapea algunos caracteres, CREO que son estos
                     *        (https://phabricator.wikimedia.org/diffusion/EDHT/repository/master/)
                     */
                    .map(function(char) { return '/\\*?"<>|~'.includes(char) ? char.charCodeAt(0).toString(16) : char; })
                    /* Si los capturing groups son undefined pongo el placeholder de mediawiki: '_' */
                    .map(function(char) { return char || '_'; })
                    /* Estas tres letras nos dan el directorio, así que lo hago todo string */
                    .join('/')
                    /* La estructura de directorios es toda en minúscula */
                    .toLowerCase() + '/';
    }

    /* MediaWiki: resources/src/mediawiki/mediawiki.util.js:84
     *            (https://github.com/wikimedia/mediawiki/blob/master/resources/src/mediawiki/mediawiki.util.js)
     * Lo usable de ahí es nada más reemplazar los espacios por '_'
     */
    function mediawikiUrlify(title) {
        return title.replace(/ /g, '_');
    }

})();