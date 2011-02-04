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

if you want inline logic, wrap it up in a function which returns an object.

keys that would confuse the real compiler, coffee-script, must be quoted.
