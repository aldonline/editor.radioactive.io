radioactive = require 'radioactive'

delay = (f) -> setTimeout f, 500

say_hello = radioactive.sync ( name, cb ) -> delay ->
  cb null, "Hello #{name}!"

name_ = radioactive.cell init:'Bob'

'input'._ type:'text', bind:name_
'p'._ -> say_hello name_()

'p'._ ->
  h = -> say_hello name_()
  if ( radioactive.busy h ) then '...' else h()
