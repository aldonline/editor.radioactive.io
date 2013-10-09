cell = require 'reactive-supercell'
$ = require './jquery'

serial = 0

module.exports =

  get_or_set_id: ( elm ) ->
    e = $(elm)
    if ( id = e.attr 'id' )?
      id
    else
      id = 'id__' + serial++
      e.attr id: id
      id

  serial: -> serial++

  # TODO: use events
  get_win_width_cell: ->
    dw_ = cell init: 940
    $ ->
      d = $(window)
      setInterval ( -> dw_ d.width() ), 300
    dw_