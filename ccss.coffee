css = ''

compile = (rules) ->
  for selector, declarations of rules
    children = {}
    text = ''

    for property, value of declarations
      if typeof value is 'object'
        children["#{selector} #{property}"] = value
      else
        text += "  #{property}: #{value};\n"

    if text
      #we have to check; this level could just be for nesting.
      css += selector + ' {\n'
      css += text
      css += '}\n'

    compile children

@compile = (rules) ->
  compile rules
  ret = css
  css = ''
  ret
