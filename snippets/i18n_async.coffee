radioactive = require 'radioactive'

# a cell to hold the current language
lang_ = radioactive.cell init: 'en'

# a naive approach to a database of labels
data =
  hello_message:
    en: 'Hello!'
    es: 'Hola!'
  login:
    en: 'Login'
    es: 'Entrar'

# list of labels so we can build a menu automatically
langs = en: 'English', es: 'Español'

delay = -> setTimeout arguments[1], arguments[0]

# the magic function that we use througout the UI
# this time it is async
# note that an async function must take
# all of its parameters as arguments
# it must be a "pure" function
i18n_async = (key, lang, cb) -> delay 1000, -> cb null, data[key][lang]
i18n_sync = radioactive.sync i18n_async

# lets build a nice UI to pick a language
menu_ui = ->
  'ul.nav.nav-pills'._ ->
    for k, v of langs then do (k, v) ->
      'li'._
        '.active': -> lang_() is k
        content: ->
          'a'._
            href: '#'
            # on click we update the value of the cell
            # this will invalidate all functions depending on it
            '!click': -> ( ( lang_ k ); false )
            content: -> v


# and build the UI for this example calling the i18n function
# when needed
'.well'._ ->
    i18n = (key) -> i18n_sync key, lang_()
    menu_ui()
    'hr'._()
    'p'._ -> i18n 'hello_message'
    'button.btn'._ -> i18n 'login'
    'hr'._()