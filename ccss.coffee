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

    for property, value of declarations
      if typeof value is 'object'
        delete declarations[property]
        children["#{selector} #{property}"] = value

    css += selector + ' {\n'
    for property, value of declarations
      css += "  #{property}: #{value};\n"
    css += '}\n'

    parse children

parse rules

console.log css
