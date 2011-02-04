#!/usr/bin/env coffee

boxShadow = (arg) ->
  '-webkit-box-shadow': arg
  '-moz-box-shadow':    arg
  'box-shadow':         arg

lighten = saturate = (color, diff) ->#TODO
  color

rules =
  '.box': do ->
    base = '#f938ab'
    color: saturate base, '5%'
    'border-color': lighten base, '5%'
    div:
      boxShadow '0 0 5px 0.4'

css = ''

parse = (rules) ->
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

    parse children

parse rules

console.log css
