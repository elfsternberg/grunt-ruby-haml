module.exports = (grunt) ->

    grunt.initConfig
        pkg: grunt.file.readJSON('package.json')

        jshint:
            files: [ "src/**/*.js", "test/**/*.js" ]
            options:
                curly: true
                eqeqeq: true
                immed: true
                latedef: true
                newcap: true
                noarg: true
                sub: true
                undef: true
                boss: true
                eqnull: true
                node: true
                es5: true

            globals: {}

        clean:
            files: ["tmp/"]

        coffee:
            rubyHaml:
                files:
                    "tasks/ruby-haml.js": "src/ruby-haml.coffee"
                options:
                    bare: false

        rubyHaml:
            test_html:
                files: [
                    {"tmp/01_straight.html": "test/fixtures/01_straight.haml"}
                    {"tmp/02_scored.html": "test/fixtures/02_scored.haml"}
                ]
            test_js:
                files: [
                    {"tmp/01_straight.js": "test/fixtures/01_straight.haml"}
                    {"tmp/02_scored.js": "test/fixtures/02_scored.haml"}
                ]
                options:
                    templatize: true

        nodeunit:
            files: [ "test/*.js" ]

        watch:
            files: "<config:jshint.files>"
            tasks: "default"


    grunt.loadTasks "tasks"

    grunt.loadNpmTasks('grunt-coffee')
    grunt.loadNpmTasks('grunt-contrib-watch')
    grunt.loadNpmTasks('grunt-contrib-jshint')
    grunt.loadNpmTasks('grunt-contrib-nodeunit')
    grunt.loadNpmTasks('grunt-contrib-clean')

    grunt.registerTask "default", ["clean", "coffee:rubyHaml", "rubyHaml:test_html", "rubyHaml:test_js", "nodeunit", "clean"]
