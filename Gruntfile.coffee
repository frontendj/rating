module.exports = (grunt) ->
  'use strict'

  require('load-grunt-tasks')(grunt)

  debug = !!grunt.option('debug')
  prefix = if debug then '' else '/rating/'

  grunt.initConfig

    jquery:
      version: '1.8.3'
      dest: 'build/js/jquery.custom.js'
      minify: true

    banner: '/* Тестовое задание на вакансию веб-технолога */\n'

    coffee:
      compile:
        files:
          'build/js/scripts.js': 'src/js/rating.coffee'

    slim:
      dist:
        files:
          'index.html': 'src/slim/index.slim'
      dev:
        files:
          'index.html': 'src/slim/index.slim'

    compass:
      dist:
        options:
          sassDir: 'src/sass'
          cssDir: 'build/css'
          environment: 'development'
          outputStyle: 'expanded'

    uglify:
      main:
        options:
          banner: '<%= banner %>'
          compress:
            global_defs:
              DEBUG: debug
        files:
          'build/js/scripts.js': 'build/js/scripts.js'

    replace:
      version:
        files:
          'index.html': 'index.html'
        options:
          patterns: [
            {
              match: /(\.js|\.css)[^"]*/gi
              replacement: '$1?<%= grunt.template.today("yyyymmddHHMM") %>'
            }
            {
              match: /"build/gi
              replacement: '"'+prefix+'build'
            }
          ]

    watch:
      compass:
        options:
          atBegin: true
        files: ['src/sass/**']
        tasks: ['compass']
      slim:
        options:
          atBegin: true
        files: ['src/slim/index.slim']
        tasks: ['slim']
      coffee:
        options:
          atBegin: true
        files: ['src/js/**']
        tasks: ['coffee']

  grunt.registerTask 'default', ['coffee', 'jquery', 'slim', 'compass', 'replace']
  grunt.registerTask 'build', ['coffee', 'slim', 'compass', 'replace']
