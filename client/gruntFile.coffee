module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-html2js"
  grunt.loadNpmTasks "grunt-recess"
  grunt.loadNpmTasks "grunt-bower-task"

  grunt.registerTask "default", ['build']
  grunt.registerTask "build", ["clean", "jade", "html2js", "coffee", "copy", "concat", "recess:build", "bower", "clean:tmp"]
  grunt.registerTask "release", ["clean", "jade", "html2js", "coffee", "copy", "concat", "recess:min", "bower", "clean:tmp"]
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

    bower:
      install:
        options:
          targetDir: '<%= distdir %>'
          layout: 'byComponent'
          install: true
          verbose: true
          cleanTargetDir: false
          cleanBowerDir: false
          bowerOptions: {}
    copy:
      assets:
        files: [
          dest: "<%= distdir %>"
          src: "**"
          expand: true
          cwd: "src/assets/"
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
        src: ["<%=distdirtmp%>/app.js", "<%= distdirtmp %>/templates/*.js"]
        dest: "<%= distdir %>/app.js"

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