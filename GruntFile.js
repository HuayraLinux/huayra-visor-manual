module.exports = function (grunt) {
  grunt.initConfig({
    nodewebkit: {
                  options: {
                            build_dir: './webkitbuilds',
                            mac: true,
                            win: true,
                            linux32: true,
                            linux64: true
                },
                src: ['./src/**/*']
            },
            'string-replace': {
              kit: {
                src: 'src/documentacion/**/*.html',
                dest: './',
                options: {
                  replacements: [{
                    pattern: /<div id="content"/ig,
                    replacement: function (match, offset, string) {
                      return '\n' +
                        		 '<link rel="stylesheet" type="text/css" href="app://./css/bootstrap.css"/>\n' +
                        		 '<link rel="stylesheet" type="text/css" href="app://./estilo.css"/>\n' +
                        		 '<script type="text/javascript" src="app://./barra.js"></script>\n\n' + 
                        		 '<script type="text/javascript" src="app://./js/bootstrap.js"></script>\n\n' + 
                        
                        		 "<div id='navegador'> \n" +
                        	   "  <a class='btn btn-success btn-xs' onclick='history.back()'>« Atrás</a> \n" +
            								 "  <a class='btn btn-success btn-xs' onclick='history.forward()'>Adelante »</a> \n" +
            								 "  <a class='btn btn-info btn-xs derecha' href='app://./documentacion/buscar.html'>Buscar</a> \n" +
        										 "</div> \n" +
                        
                        	   '<div class="contenido" id="content"';
                    }   
                  }]  
                }   
              }   
             }  
    });

    grunt.loadNpmTasks('grunt-node-webkit-builder');
    grunt.loadNpmTasks('grunt-string-replace');
 }

