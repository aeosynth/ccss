#!/usr/bin/env coffee

boxShadow = (arg) ->
  WebkitBoxShadow: arg
  MozBoxShadow:    arg
  boxShadow:       arg

lighten = saturate = (color, diff) ->#TODO
  color

rules =
  '.box': do ->
    base = '#f938ab'
    color: saturate base, '5%'
    borderColor: lighten base, '5%'
    div:
      boxShadow '0 0 5px 0.4'

css = ''

parse = (rules) ->
  for selector, declarations of rules
    children = {}

    css += selector + ' {\n'

    for property, value of declarations
      if typeof value is 'string'
        property = property.replace /[A-Z]/g, (str) -> '-' + str.toLowerCase()
        css += "  #{property}: #{value};\n"
      else
        children["#{selector} #{property}"] = value

    css += '}\n'

    parse children

parse rules

console.log css
