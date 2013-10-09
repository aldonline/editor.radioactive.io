ra = require 'radioactive'

module.exports = ( src ) ->
  js = CoffeeScript.compile src
  js = "window.__compiled__ = function(){ #{js} }"
  eval js
  f = window.__compiled__
  delete window.__compiled__
  ra.nodes f