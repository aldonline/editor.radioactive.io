radioactive = require 'radioactive'

name_cell_ = radioactive.cell init: 'Change Me!'

'.well'._ ->
  'input'._ type:'text', bind: name_cell_
  'p'._ name_cell_