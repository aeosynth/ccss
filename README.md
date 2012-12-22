CoffeeScript CSS

despite the name, CoffeeScript is not required; it just makes writing objects
(as well as everything else) easier. You could create a JSON string in another
language, parse it in node, and render it with ccss.

install: `npm install ccss`

main.coffee:

    ccss = require 'ccss'

    template = require './template.coffee'
    css = ccss.compile template
    require('fs').writeFileSync 'main.css', css

    #or all at once: ccss.compileFile './template.coffee', 'main.css'

template.coffee:

    borderRadius = (str) ->
      WebkitBorderRadius: str
      MozBorderRadius:    str
      borderRadius:       str

    boxShadow = (str) ->
      WebkitBoxShadow: str
      MozBoxShadow:    str
      boxShadow:       str

    module.exports =
      form:
        input:
          padding: '5px'
          border: '1px solid'
          mixins: borderRadius '5px'
      '#id .className': do ->
        opaque = 1
        translucent = opaque / 2
        img:
          mixins: [
            borderRadius '5px'
            boxShadow '5px'
          ]
          opacity: translucent
        'img:hover':
          opacity: opaque

main.css:

    form input {
      padding: 5px;
      border: 1px solid;
      -webkit-border-radius: 5px;
      -moz-border-radius: 5px;
      border-radius: 5px;
    }
    #id .className img {
      opacity: 0.5;
      -webkit-border-radius: 5px;
      -moz-border-radius: 5px;
      border-radius: 5px;
      -webkit-box-shadow: 5px;
      -moz-box-shadow: 5px;
      box-shadow: 5px;
    }
    #id .className img:hover {
      opacity: 1;
    }

the core of the compiler is simply this:

iterate over the key / values of an object; if the value is another object,
append the key to the current selector, and recurse; else generate css.

to reduce the amount of quoting, if a css property has a capital letter C,
it will be transformed into -c; selectors are not touched.

# Related

[CoffeeKup](http://coffeekup.org/) - CoffeeScript to HTML

[ckup](http://satyr.github.com/ckup/) - [Coco](http://satyr.github.com/coco/) to both HTML and CSS

[CoffeeStylesheets](https://github.com/mikesmullin/coffee-stylesheets) - Another CoffeeScript to CSS approach
