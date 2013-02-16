# grunt-ruby-haml

Compile your HTML templates using the Ruby HAML command-line compiler

## WHAT!? WHY!?!?!?

Because I like [underscore](http://underscorejs.org/), and underscore
templates.  They come free with [Backbone](http://backbonejs.org/).
And Ruby's HAML treats them without abusing them.  It's not a great
solution, but it's better than trying to write yet another HAML
parser.

And before you get me started on Jade, or Mustache, or whatever:
forget it.  Jade is a big learning curve for little reward, and the
rest are templating languages in their own right.

## Getting Started

Make sure you have Ruby and Haml available in you $PATH.

Install this grunt plugin next to your project's [grunt.js
gruntfile][getting_started] with: `npm install grunt-ruby-haml`

Then add this line to your project's `grunt.js` gruntfile:

```javascript
grunt.loadNpmTasks('grunt-ruby-haml');
```

## Documentation

Make sure you have underscore installed:

    npm install underscore
    
Then you'll need to install `grunt-ruby-haml`:

    npm install grunt-ruby-haml

Then modify your `Gruntfile.js` file by adding the following line:

    grunt.loadNpmTasks('grunt-ruby-haml');

Then add some configuration for the plugin like so:

    grunt.initConfig({
        ...
        rubyHaml: {
          app: {
            files: {
                "public/index.html": "src/index.haml"
            },
            options: {
                templatize: false
            }
          }
        },
        ...
    });

Then just run `grunt rubyHaml` and enjoy!

Ruby-HAML will, by default, generate HTML.  With the 'templatize'
option set to True, it will instead spit out an underscore template
ready to be rendered, wrapped in an AMD-compliant define() call.  This
may be useful to some of you who want to use the output of the HAML
engine as a pre-parsed underscore template.


## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [grunt][grunt].

## Release History
0.0.1 - Just what I've always run.  Don't expect miracles

## License
Copyright (c) 2013 Elf M. Sternberg
Licensed under the MIT license.
