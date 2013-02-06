"use strict";

var grunt = require('grunt'),
    fs = require('fs'),
    path = require('path'),
    files = [
        ["tmp/01_straight.html", "test/expected/01_straight.html"],
        ["tmp/02_scored.html", "test/expected/02_scored.html"],
        ["tmp/01_straight.js", "test/expected/01_straight.js"],
        ["tmp/02_scored.js", "test/expected/02_scored.js"]
    ]


fs.existsSync = fs.existsSync ? fs.existsSync : path.existsSync;

exports.coffee = {

    setUp: function(done) {
        done();
    },
    
    'task': function(test) {
        test.expect(files.length);
        files.forEach(function(file) {
            test.equal(grunt.file.read(file[0]), grunt.file.read(file[1]));
        });
        test.done();
    }
};
