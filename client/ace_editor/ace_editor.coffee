ra          = require 'radioactive'
util        = require './util'

###
draws a DIV with an ACE editor and a preview
###
module.exports = ( { name, height, preview_side, preview_span } = {} ) ->
  
  preview_side  ?= 'right'
  preview_span  ?= 5
  HEIGHT         = height or '300px'

  editor_span = 12 - preview_span

  preview_id = 'preview_' + util.serial()

  draw_editor_div = ->
    ".span#{editor_span}"._
      $backgroundColor: '#333'
      $marginLeft:      '0px'
      $height:          HEIGHT
      $position:        'relative'
      ->
        '.ace'._
          $fontSize:      '11px'
          'data-preview': preview_id
          $height:        HEIGHT
          content:        snippet

  draw_preview_div = ->
    ".span#{preview_span}"._
        $backgroundColor: '#ccc'
        $height:          HEIGHT
        $overflowY:       'scroll'
        $position:        'relative'
        ->
          '.preview'._
            $paddingLeft:  '10px'
            $paddingRight: '10px'
            id: preview_id
            content: ''

  '.row.snippet'._
    $marginLeft: 0
    ->
      fs = [ editor_div, preview_div ]
      if preview_side is 'left' then fs.reverse()
      f() for f in fs


