module.exports = function (grunt) {
  grunt.initConfig({
    nodewebkit: {
                  options: {
                            build_dir: './webkitbuilds',
                            mac: true, // We want to build it for mac
                            win: true, // We want to build it for win
                            linux32: true, // We don't need linux32
                            linux64: true // We don't need linux64
                },
                src: ['./src/**/*'] // Your node-wekit app
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
                        		 '<link rel="stylesheet" type="text/css" href="app://./estilo.css"/>\n' +
                        		 '<script type="text/javascript" src="app://./app.js"></script>\n\n' + 
                        
                        		 "<div id='navegador'> \n" +
                        	   "  <button onclick='history.back()'>« Atras</button> \n" +
            								 "  <button onclick='history.forward()'>Avanzar »</button> \n" +
            								 "  <a href='app://buscar.html'>Buscar</a> \n" +
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
    //grunt.registerTask('default', ['grunt-string-replace']);
 }

