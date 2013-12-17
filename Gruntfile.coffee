module.exports = (grunt) ->
  grunt.loadNpmTasks('grunt-mocha-test')

  # Project configuration.
  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')
    mochaTest:
      test:
        options:
          reporter: 'spec'
        src: ['test/**/*.js', 'test/**/*.coffee']
  )

  # Default task(s).
  grunt.registerTask('default', 'mochaTest')
