radioactive = require 'radioactive'

tags_ = radioactive.cell init: 'coffee,nature'
img_ = radioactive.cell()

is_ok = -> tags_().length >= 4
fetch_images = -> flickr_sync tags_()

draw_img = (img) ->
  dim = -> if img is img_() then 120 * 2 else 120
  'img.img-polaroid'._
    src: img.media.m
    $width: dim, $height:dim
    '!click': -> img_ img

draw_search_box = ->
  'input'._
    type:'text'
    $width:300
    placeholder: 'flickr search'
    $backgroundColor: -> if is_ok() then 'white' else 'pink'
    bind: tags_

draw_result = ->
  if ( radioactive.ready -> fetch_images() )
    draw_img img for img in fetch_images()
  else
    '.progress.progress-striped.active .bar'._ $width: '100%'

'div'._ $marginTop:10, ->
    draw_search_box()
    '.well'._ $height: 270, $overflowY: 'scroll', ->
      if is_ok()
        draw_result()
      else
        '.alert.alert-error'._ 'Enter a valid search'
    'span'._ -> img_()?.title or '( no image selected) '

flickr_async = ( tags, cb ) ->
  url = "http://api.flickr.com/services/feeds/photos_public.gne?jsoncallback=?"
  opts = format: 'json', tagmode:'all', tags: tags
  $.getJSON url, opts, (d) -> cb null, d.items

flickr_sync = radioactive.sync flickr_async