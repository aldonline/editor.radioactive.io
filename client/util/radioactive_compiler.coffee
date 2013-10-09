raml = require 'raml'

module.exports = ( src ) ->
  js = CoffeeScript.compile src
  window.radioactive =
    syncify:    require('syncify')
    nodes:      require('raml').nodes
    reactivity: require('reactivity')
    cell:       require('reactive-supercell')
  js = "window.__compiled__ = function(){ #{js} }"
  eval js
  f = window.__compiled__
  delete window.__compiled__
  raml.nodes f