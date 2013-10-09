util = require '../util'
radioactive = require 'radioactive'
_ = require 'underscore'
customize = require './customize'

# coffeescript was loaded via normal HTML script tags
cs = window.CoffeeScript

# snippet code will need access to a global radioactive instance
window.radioactive = radioactive

delay = -> setTimeout arguments[1], arguments[0]

setup_editor_and_preview = ( $editor, $preview ) ->
  customize editor = ace.edit $editor[0]
  session = editor.getSession()
  preview_id = '#' + util.get_or_set_id $preview[0]
  handle_change = ->
    value = session.getValue()
    js = CoffeeScript.compile value
    js = """
    (function(){
      var radioactive = window.radioactive;
      var f = function(){ #{js} }
      var cb = function( err, res ){
        var $p = $("#{preview_id}")
        $p.children().remove()
        $p.append( res )
        console.log( err, res )
      }
      radioactive.nodes( f, cb )
    })()
    """
    eval js
  handle_change2 = _.debounce handle_change, 500
  delay 300, ->
    session.on 'change', (e) -> handle_change2()
    handle_change()


setup_ace_editors = ->
  $('.ace').each (i, e) ->
    $editor = $ e
    unless $editor.data 'ace'
      if $editor.text().length > 0
        $editor.data 'ace', yes
        

# monitor for newly created ace editors
$ -> setInterval setup_ace_editors, 300




