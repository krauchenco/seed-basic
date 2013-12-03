module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-html2js"
  
  grunt.registerTask "default", ['build']
  grunt.registerTask "build", ["clean", "jade", "html2js", "coffee", "copy", "concat", "clean:tmp"]#"jshint", "build"]
  grunt.registerTask "build-watch", ['watch:build']

  grunt.registerTask "timestamp", ->
    grunt.log.subhead Date()

  grunt.initConfig
    distdir: "dist"
    distdirtmp: "distdirtmp" # usado pra colocar os templates do angular jade pra transformar em JS no distdir
    pkg: grunt.file.readJSON("package.json")
    banner: "/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today(\"yyyy-mm-dd\") %>\n" +
      "<%= pkg.homepage ? \" * \" + pkg.homepage + \"\\n\" : \"\" %>" +
      " * Copyright (c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author %>;\n" +
      " * Licensed <%= _.pluck(pkg.licenses, \"type\").join(\", \") %>\n */\n"

    clean:
      dist: ["<%= distdir %>"]
      tmp: ["<%= distdirtmp %>"]
    copy:
      assets:
        files: [
          dest: "<%= distdir %>"
          src: "**"
          expand: true
          cwd: "src/assets/"
        ]
      vendor:
        files: [
          dest: "<%= distdir %>/jquery.js"
          src: "vendor/jquery/jquery.js"
        ,
          dest: "<%= distdir %>/bootstrap.js"
          src: "vendor/bootstrap/dist/js/bootstrap.js"
        ,
          expand: true
          dest: "<%= distdir %>/fonts"
          src: "**"
          cwd: "vendor/bootstrap/dist/fonts"
        ]
    coffee:
      compileJoined:
        options:
          join: true
        files:
          '<%= distdir %>/app.js': 'src/**/*.coffee'
    jade:
      compile:
        options:
          data:
            debug: false
        files:[
          cwd: "src/"
          src: "**/*.tpl.jade"
          dest: "<%= distdirtmp %>"
          expand: true
          ext: ".tpl.html"
        ,
          cwd: "src/"
          src: ["**/*.jade", "!**/*.tpl.jade"]
          dest: "<%= distdir %>"
          expand: true
          ext: ".html"
        ]
#    karma:
#      unit:
#        options: karmaConfig("test/config/unit.js")
#
#      watch:
#        options: karmaConfig("test/config/unit.js",
#          singleRun: false
#          autoWatch: true
#        )

    html2js:
      app:
        options:
          base: "<%= distdirtmp %>/app"

        src: ["<%= distdirtmp %>/app/**/*.tpl.html"]
        dest: "<%= distdirtmp %>/templates/app.js"
        module: "templates.app"

      common:
        options:
          base: "<%= distdirtmp %>/common"

        src: ["<%= distdirtmp %>/common/**/*.tpl.html"]
        dest: "<%= distdirtmp %>/templates/common.js"
        module: "templates.common"

    concat:
      angular:
        src: ["vendor/angular/angular.js", "vendor/angular-route/angular-route.js"]
        dest: "<%= distdir %>/angular.js"

      bootstrap:
        src: ["vendor/bootstrap/dist/css/bootstrap.css", "vendor/bootstrap/dist/css/bootstrap-theme.css"]
        dest: "<%= distdir %>/bootstrap.css"

      templates:
        src:["<%=distdir%>/app.js", "<%= distdirtmp %>/templates/*.js"]
        dest: "<%= distdir %>/app.js"

    watch:
      build:
        files: ['src/**/*']
        tasks: ['build', 'timestamp']

#    uglify:
#      dist:
#        options:
#          banner: "<%= banner %>"
#
#        src: ["<%= src.js %>", "<%= src.jsTpl %>"]
#        dest: "<%= distdir %>/<%= pkg.name %>.js"
#
#      angular:
#        src: ["<%= concat.angular.src %>"]
#        dest: "<%= distdir %>/angular.js"
#
#      mongo:
#        src: ["vendor/mongolab/*.js"]
#        dest: "<%= distdir %>/mongolab.js"
#
#      bootstrap:
#        src: ["vendor/angular-ui/bootstrap/*.js"]
#        dest: "<%= distdir %>/bootstrap.js"
#
#      jquery:
#        src: ["vendor/jquery/*.js"]
#        dest: "<%= distdir %>/jquery.js"
#
#    recess:
#      build:
#        files:
#          "<%= distdir %>/<%= pkg.name %>.css": ["<%= src.less %>"]
#
#        options:
#          compile: true
#
#      min:
#        files:
#          "<%= distdir %>/<%= pkg.name %>.css": ["<%= src.less %>"]
#
#        options:
#          compress: true
#
#    watch:
#      all:
#        files: ["<%= src.js %>", "<%= src.specs %>", "<%= src.lessWatch %>", "<%= src.tpl.app %>", "<%= src.tpl.common %>", "<%= src.html %>"]
#        tasks: ["default", "timestamp"]
#
#      build:
#        files: ["<%= src.js %>", "<%= src.specs %>", "<%= src.lessWatch %>", "<%= src.tpl.app %>", "<%= src.tpl.common %>", "<%= src.html %>"]
#        tasks: ["build", "timestamp"]
#
#    jshint:
#      files: ["gruntFile.js", "<%= src.js %>", "<%= src.jsTpl %>", "<%= src.specs %>", "<%= src.scenarios %>"]
#      options:
#        curly: true
#        eqeqeq: true
#        immed: true
#        latedef: true
#        newcap: true
#        noarg: true
#        sub: true
#        boss: true
#        eqnull: true
#        globals: {}
