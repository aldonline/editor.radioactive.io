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

# the magic function that we use througout the UI
i18n = (key) -> data[key][lang_()]

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
    menu_ui()
    'hr'._()
    'p'._ -> i18n 'hello_message'
    'button.btn'._ -> i18n 'login'
    'hr'._()
    
    # you could also query the lang_ cell directly
    'div'._ -> switch lang_()
        when 'en'
            """
            Internationalization comes for free with simple reactivity.
            Just store the current language in a cell and use
            regular functions
            """
        when 'es'
            """
            Internacionalizar una interfaz es tan simple como
            utilizar cells y funciones
            """  
