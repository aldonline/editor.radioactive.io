cell = require 'reactive-supercell'
reactivity = require 'reactivity'
rac = require './client/util/radioactive_compiler'
customize = require './client/ace_editor/customize'
_ = require 'underscore'
util = require './client/util'

delay = -> setTimeout arguments[1], arguments[0]

TOTAL = util.get_win_width_cell()

PREVIEW_WIDTH = -> 960
EDITOR_WIDTH  = -> TOTAL() - PREVIEW_WIDTH()

code = cell persist: 'standalone_editor_code', init: ''

$ ->
  delay 500, -> setup_editor_and_preview $('#editor'), $('#preview')

  $('body').css height: '100%'
  $('body').append 'div'._ ->
    'div'._
      $backgroundColor:'yellow'
      ->
        'h1'._ $margin:0, $padding: 5, 'Radioactive Coffee'
    'div'._
      $backgroundColor: '#eee'
      $width: '100%'
      $height: '100%'
      $overflowX: 'hidden'
      ->
        editor_ui()
        preview_ui()
        'div'._ $clear: 'both'

editor_ui = ->
  'div'._
    $backgroundColor: '#333'
    $marginLeft:      '0px'
    $height:          '100%'
    $width:           EDITOR_WIDTH
    $float:           'left'
    ->
      '#editor.ace'._
        $fontSize:      '13px'
        $height:        900

preview_ui = ->
  "div"._
      $backgroundColor: '#eee'
      $height:          '100%'
      $width:           PREVIEW_WIDTH
      $overflowY:       'scroll'
      $float:           'right'
      ->
        '#preview'._
          $paddingLeft:  '5px'
          $paddingRight: '5px'
          $height: '100%'
          ''

setup_editor_and_preview = ( editor, preview ) ->
  $editor = $(editor)
  $preview = $(preview)
  customize e = ace.edit $editor[0]
  session = e.getSession()

  handle_change = -> code session.getValue()

  reactivity code, (e, r) ->
    $preview.children().remove()
    try
      $preview.append rac r
    catch e
      $preview.append '.alert.alert-error h2'._ e.toString()

  handle_change2 = _.debounce handle_change, 500
  delay 300, ->
    session.on 'change', (e) -> handle_change2()
    if code()?
      session.setValue code()

