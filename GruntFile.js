module.exports = function (grunt) {
  grunt.initConfig({
    'nodewebkit': {
      kit:{
        options: {
          build_dir: './webkitbuilds',
          mac: true,
          win: true,
          linux32: true,
          linux64: true
        },
        src: ['./src/**/*']
      }
    }
  });

  //grunt.loadNpmTasks('grunt-node-webkit-builder');
  grunt.loadNpmTasks('grunt-string-replace');

  //grunt.registerTask('default', ['nodewebkit','string-replace']);
  grunt.registerTask('default', ['string-replace']);

}

