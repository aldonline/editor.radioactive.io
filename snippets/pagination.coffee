radioactive = require 'radioactive'

num_pages_R = radioactive.cell init: 6
limit_R = radioactive.cell init: 10
current_page_RW = radioactive.cell init: 1

'.well'._ $textAlign:'center', ->
  'h1'._ -> 'Page: ' + current_page_RW() + '/' + num_pages_R()
  n = num_pages_R()
  if n > 1
    p = current_page_RW
    m = limit_R()
    x = ( label, muted_condition, click ) ->
      'li a'._
        href:'#'
        '.muted': muted_condition
        '!click': ( -> click() unless muted_condition() ; false )
        content: label
    if n > m
      '.well'._ 'too many to show'
    else
      '.pagination ul'._ ->
        x 'prev', ( -> p() is 1 ), ( -> p p() - 1 )
        for i in [1..n] then do (i) ->
          x String(i), ( -> p() is i ), ( -> p i )
        x 'next', ( -> p() is n ), ( -> p p() + 1 )