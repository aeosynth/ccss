var extend, fs;
fs = require('fs');
extend = function(object, properties) {
  var key, value;
  for (key in properties) {
    value = properties[key];
    object[key] = value;
  }
  return object;
};
this.compile = function(rules) {
  var css, declarations, key, mix, mixin, nested, pairs, selector, value, _i, _len;
  css = '';
  for (selector in rules) {
    pairs = rules[selector];
    declarations = '';
    nested = {};
    if (mixin = pairs.mixin, pairs) {
      delete pairs.mixin;
      if (!(mixin instanceof Array)) {
        mixin = [mixin];
      }
      for (_i = 0, _len = mixin.length; _i < _len; _i++) {
        mix = mixin[_i];
        extend(pairs, mix);
      }
    }
    for (key in pairs) {
      value = pairs[key];
      if (typeof value === 'object') {
        nested["" + selector + " " + key] = value;
      } else {
        key = key.replace(/[A-Z]/g, function(s) {
          return '-' + s.toLowerCase();
        });
        declarations += "  " + key + ": " + value + ";\n";
      }
    }
    if (declarations) {
      css += selector + ' {\n';
      css += declarations;
      css += '}\n';
    }
    css += this.compile(nested);
  }
  return css;
};
this.compileFile = function(infile, outfile) {
  var css, rules;
  rules = require(process.cwd() + '/' + infile);
  css = this.compile(rules);
  outfile || (outfile = infile.replace(/coffee$/, 'css'));
  return fs.writeFileSync(outfile, css);
};