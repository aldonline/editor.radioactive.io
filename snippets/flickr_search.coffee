radioactive = require 'radioactive'

flickr = radioactive.sync ( tags, cb ) ->
  url = "http://api.flickr.com/services/feeds/photos_public.gne?jsoncallback=?"
  $.getJSON url, {format: 'json', tagmode:'all', tags: tags}, (d) -> cb null, d.items

query    = radioactive 'coffee,nature'
selected = radioactive()
fetch_images = -> flickr query()
is_valid     = -> query().length >= 4
is_ready     = -> not radioactive.busy -> fetch_images()
deselect     = -> selected null

'input.input-xlarge'._ type:'text', bind: query, onfocus:deselect, $marginTop: 10
'.well'._  $overflowY: 'scroll', $height:340, ->
  if selected()?
    'img.img-polaroid'._ src: selected().media.m
    'br'._()
    'a'._ onclick:deselect, '<< Back'
  else
    if is_valid()
      if is_ready()
        img i for i in fetch_images()
      else
        '.progress.progress-striped.active .bar'._ $width: '100%'
    else
      '.alert.alert-error'._ 'Enter a valid search'

wh = (c) -> $width: c, $height: c
img = (i) -> 'img.img-polaroid'._ src: i.media.m, wh(90), onclick: -> selected i