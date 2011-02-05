css = ''

compile = (ccss) ->
  for selector, pairs of ccss
    # a pair can be a css declaration, or a pair of the child ccss object
    child = {}
    declarations = ''

    for key, value of pairs
      if typeof value is 'object'
        child["#{selector} #{key}"] = value
      else
        #borderRadius -> border-radius
        key = key.replace /[A-Z]/g, (s) -> '-' + s.toLowerCase()
        declarations += "  #{key}: #{value};\n"

    if declarations
      #we have to check; this level could just be for nesting.
      css += selector + ' {\n'
      css += declarations
      css += '}\n'

    compile child

@compile = (ccss) ->
  compile ccss
  ret = css
  css = ''
  ret
