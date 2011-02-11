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
  var child, children, css, declarations, key, mixin, mixins, nested, pairs, selector, split, value, _i, _j, _len, _len2, _ref;
  css = '';
  for (selector in rules) {
    pairs = rules[selector];
    declarations = '';
    nested = {};
    if (mixins = pairs.mixins, pairs) {
      delete pairs.mixins;
      _ref = [].concat(mixins);
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        mixin = _ref[_i];
        extend(pairs, mixin);
      }
    }
    for (key in pairs) {
      value = pairs[key];
      if (typeof value === 'object') {
        children = [];
        split = key.split(/\s*,\s*/);
        for (_j = 0, _len2 = split.length; _j < _len2; _j++) {
          child = split[_j];
          children.push("" + selector + " " + child);
        }
        nested[children.join(',')] = value;
      } else {
        key = key.replace(/[A-Z]/g, function(s) {
          return '-' + s.toLowerCase();
        });
        declarations += "  " + key + ": " + value + ";\n";
      }
    }
    declarations && (css += "" + selector + " {\n" + declarations + "}\n");
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