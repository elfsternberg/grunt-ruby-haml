#
# grunt-ruby-haml
#
# Copyright (c) 2013 Elf M. Sternberg
# Licensed under the MIT license.
#

_ = require 'underscore'

module.exports = (grunt) ->

    hamlize = (src, destPath, options, done) ->
        args =
            cmd: "haml"
            args: [ "--unix-newlines", "--no-escape-attrs", "--double-quote-attributes", src ]

        grunt.util.spawn args, (err, result) ->
            [ext, result] = if options.templatize
                [".js", "define(function() { return " + _.template(result.stdout).source + "});"]
            else
                ["html", result.stdout]

            dest = destPath
            destPath = (if dest then dest else path.dirname(src))
            if destPath.indexOf(ext, destPath.length - ext.length) == -1
                dest = path.join(destPath, path.basename(src, ".haml") + ext)

            grunt.file.write dest, result
            done(null)

    grunt.registerMultiTask "rubyHaml", "Compile HAML with Ruby", ->
        options = @options({templatize: false})
        done = @async()
        sources = _.flatten(([i, file.dest] for i in file.src for file in @files when file.src.length > 0), true)
        return done() if sources.length is 0
        grunt.util.async.forEachSeries sources, ((path, cb) ->
            hamlize path[0], path[1], options, cb
        ), done


