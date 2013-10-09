fs = require 'fs'
path = require 'path'

module.exports = snippet_reader = ( snippet_name, cb ) ->
  fn = path.resolve __dirname, '../snippets/' + snippet_name + '.coffee'
  fs.readFile fn, 'utf-8', ( e, r ) ->
    return cb e if e?
    try
      lines = r.split '\n'
      yes while lines.shift().trim() isnt ''
      cb null, lines.join '\n'
    catch e
      cb e