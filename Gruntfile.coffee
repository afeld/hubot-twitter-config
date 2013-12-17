module.exports = (grunt) ->
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-mocha-test')

  # Project configuration.
  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')
    mochaTest:
      test:
        options:
          reporter: 'spec'
        src: ['test/**/*.js', 'test/**/*.coffee']
    watch:
      files: ['lib/**/*', 'test/**/*']
      tasks: ['mochaTest']
  )

  # Default task(s).
  grunt.registerTask('default', 'mochaTest')
