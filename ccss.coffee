css = ''

compile = (rules) ->
  for selector, declarations of rules
    children = {}
    text = ''

    for key, value of declarations
      if typeof value is 'object'
        children["#{selector} #{key}"] = value
      else
        text += "  #{key}: #{value};\n"

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
