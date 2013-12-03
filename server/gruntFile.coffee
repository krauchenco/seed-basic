module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.registerTask "default", ["build"]
  grunt.registerTask "build", ["clean", "coffee", "copy"]
  grunt.registerTask "build-watch", ["build", "watch"]
  grunt.registerTask "release", ["build"]

  grunt.registerTask "timestamp", ->
    grunt.log.subhead Date()

  grunt.initConfig
    distdir: "dist"
    pkg: grunt.file.readJSON("package.json")
    banner: "/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today(\"yyyy-mm-dd\") %>\n" +
      "<%= pkg.homepage ? \" * \" + pkg.homepage + \"\\n\" : \"\" %>" +
      " * Copyright (c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author %>;\n" +
      " * Licensed <%= _.pluck(pkg.licenses, \"type\").join(\", \") %>\n */\n"
    clean: ["<%= distdir %>/*"]
    coffee:
      glob_to_multiple:
        expand: true
        flatten: false
        cwd: "src/"
        src: ["**/*.coffee"]
        dest: "<%= distdir %>"
        ext: ".js"

    copy:
      main:
        files: [
          expand: true
          cwd: "src/"
          src: ["cert/**"]
          dest: "<%= distdir %>/"
        ,
          expand: true
          cwd: "src/"
          src: ["node_modules/**"]
          dest: "<%= distdir %>/"
        ,
          expand: true
          flatten: false
          cwd: "src/"
          src: ["lib/**/*.js"]
          dest: "<%= distdir %>/"
        ,
          expand: true
          flatten: false
          cwd: "src/"
          src: ["*.js"]
          dest: "<%= distdir %>/"
        ]

    watch:
      all:
        files: ["src/**/*"]
        tasks: ["build", "timestamp"]
