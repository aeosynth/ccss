fs = require 'fs'

@compile = (rules) ->
  css = ''

  for selector, pairs of rules
    # a pair is either a css declaration, or a nested rule
    declarations = ''
    nested = {}

    if mixin = pairs.mixin
      delete pairs.mixin
      if typeof mixin is 'object'
        mixin = [mixin]
      for mix in mixin
        for key, value of mix
          pairs[key] = value

    for key, value of pairs
      if typeof value is 'object'
        nested["#{selector} #{key}"] = value
      else
        #borderRadius -> border-radius
        key = key.replace /[A-Z]/g, (s) -> '-' + s.toLowerCase()
        declarations += "  #{key}: #{value};\n"

    if declarations
      #we have to check; this level could just be for nesting.
      css += selector + ' {\n'
      css += declarations
      css += '}\n'

    css += @compile nested

  css

@compileFile = (infile, outfile) ->
  rules = require process.cwd() + '/' + infile
  css = @compile rules
  outfile or= infile.replace /coffee$/, 'css'
  fs.writeFileSync outfile, css
