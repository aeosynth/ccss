fs = require 'fs'

extend = (object, properties) ->
  for key, value of properties
    object[key] = value
  object

@compile = (rules) ->
  css = ''

  for selector, pairs of rules
    declarations = ''
    nested = {}

    #add mixins to the current level
    if {mixin} = pairs
      delete pairs.mixin
      unless mixin instanceof Array
        mixin = [mixin]
      for mix in mixin
        extend pairs, mix

    #a pair is either a css declaration, or a nested rule
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
