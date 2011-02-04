CoffeeScript CSS

    ccss = require 'ccss'

    rules =
      '.foo': do ->
        opaque = 1
        translucent = opaque / 2
        img:
          opacity: translucent
        'img:hover':
          opacity: opaque

    css = ccss.compile rules

    console.log css

    ### output:
    .foo img {
      opacity: 0.5;
    }
    .foo img:hover {
      opacity: 1;
    }
    ###

the core of the compiler is simply this:

iterate over the key / values of an object; if the value is another object,
append the key to the current selector, and recurse; else generate css.

if you want logic, wrap it up in a function which returns an object.

keys that would confuse the real compiler, coffee-script, must be quoted.

to reduce the amount of quoting, if a css property has a capital letter C,
it will be transformed into -c; selectors are not touched.

eg, instead of

    borderRadius = (arg) ->
      '-webkit-border-radius': arg
      '-moz-border-radius':    arg
      'border-radius':         arg

we can write

    borderRadius = (arg) ->
      WebkitBorderRadius: arg
      MozBorderRadius:    arg
      borderRadius:       arg

    '#id .className':
      borderRadius 5

compiled:

    #id .className {
      -webkit-border-radius: 5;
      -moz-border-radius: 5;
      border-radius: 5;
    }
