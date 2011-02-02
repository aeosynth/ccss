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

    css += selector + ' {\n'

    for property, value of declarations
      if typeof value is 'string'
        css += "  #{property}: #{value};\n"
      else
        children["#{selector} #{property}"] = value

    css += '}\n'

    parse children

parse rules

console.log css
