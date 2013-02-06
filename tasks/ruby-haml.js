(function() {
  var _;

  _ = require('underscore');

  module.exports = function(grunt) {
    var hamlize;
    hamlize = function(src, destPath, options, done) {
      var args;
      args = {
        cmd: "haml",
        args: ["--unix-newlines", "--no-escape-attrs", "--double-quote-attributes", src]
      };
      return grunt.util.spawn(args, function(err, result) {
        var dest, ext, _ref;
        _ref = options.templatize ? [".js", "define(function() { return " + _.template(result.stdout).source + "});"] : ["html", result.stdout], ext = _ref[0], result = _ref[1];
        dest = destPath;
        destPath = (dest ? dest : path.dirname(src));
        if (destPath.indexOf(ext, destPath.length - ext.length) === -1) {
          dest = path.join(destPath, path.basename(src, ".haml") + ext);
        }
        grunt.file.write(dest, result);
        return done(null);
      });
    };
    return grunt.registerMultiTask("rubyHaml", "Compile HAML with Ruby", function() {
      var done, file, i, options, sources;
      options = this.options({
        templatize: false
      });
      done = this.async();
      sources = _.flatten((function() {
        var _i, _len, _ref, _results;
        _ref = this.files;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          file = _ref[_i];
          if (file.src.length > 0) {
            _results.push((function() {
              var _j, _len1, _ref1, _results1;
              _ref1 = file.src;
              _results1 = [];
              for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
                i = _ref1[_j];
                _results1.push([i, file.dest]);
              }
              return _results1;
            })());
          }
        }
        return _results;
      }).call(this), true);
      if (sources.length === 0) {
        return done();
      }
      return grunt.util.async.forEachSeries(sources, (function(path, cb) {
        return hamlize(path[0], path[1], options, cb);
      }), done);
    });
  };

}).call(this);
