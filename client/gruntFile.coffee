module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-html2js"
  grunt.loadNpmTasks "grunt-recess"

  grunt.registerTask "default", ['build']
  grunt.registerTask "build", ["clean", "jade", "html2js", "coffee", "copy:assets", "copy:vendordev", "concat:js", "concat:css", "recess:build", "clean:tmp"]
  grunt.registerTask "release", ["clean", "jade", "html2js", "coffee", "copy:assets", "copy:vendormin", "concat:jsmin", "concat:jsmin", "concat:cssmin", "recess:min", "clean:tmp"]
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
      vendordev:
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
      vendormin:
        files: [
          dest: "<%= distdir %>/jquery.js"
          src: "vendor/jquery/jquery.min.js"
        ,
          dest: "<%= distdir %>/jquery.min.map"
          src: "vendor/jquery/jquery.min.map"
        ,
          dest: "<%= distdir %>/angular.min.js.map"
          src: "vendor/angular/angular.min.js.map"
        ,
          dest: "<%= distdir %>/bootstrap.js"
          src: "vendor/bootstrap/dist/js/bootstrap.min.js"
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
          '<%= distdirtmp %>/app.js': 'src/**/*.coffee'
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
      js:
        src: ["vendor/angular/angular.js", "vendor/angular-route/angular-route.js", "<%=distdirtmp%>/app.js", "<%= distdirtmp %>/templates/*.js"]
        dest: "<%= distdir %>/angular.js"

      jsmin:
        src: ["vendor/angular/angular.min.js", "vendor/angular-route/angular-route.min.js", "<%=distdirtmp%>/app.js", "<%= distdirtmp %>/templates/*.js"]
        dest: "<%= distdir %>/angular.js"

      css:
        src: ["vendor/bootstrap/dist/css/bootstrap.css", "vendor/bootstrap/dist/css/bootstrap-theme.css"]
        dest: "<%= distdir %>/bootstrap.css"

      cssmin:
        src: ["vendor/bootstrap/dist/css/bootstrap.min.css", "vendor/bootstrap/dist/css/bootstrap-theme.min.css"]
        dest: "<%= distdir %>/bootstrap.css"

    watch:
      build:
        files: ['src/**/*']
        tasks: ['build', 'timestamp']

    recess:
      build:
        files:
          "<%= distdir %>/styles.css": ["src/less/*.less"]

        options:
          compile: true

      min:
        files:
          "<%= distdir %>/styles.css": ["src/less/*.less"]

        options:
          compress: true