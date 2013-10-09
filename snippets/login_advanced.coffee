radioactive   = require 'radioactive'

email_ = radioactive.cell init: ''
password_ = radioactive.cell init: ''
section_ = radioactive.cell init: 'login'

str_is_ok    = ( str ) -> typeof str is 'string' and str.length > 3
email_ok     = -> email_re.test email_()
password_ok  = -> str_is_ok password_()

'form.well'._ ->
    'ul.nav.nav-pills'._ ->
      x = (id, label) ->
        'li'._ '.active':( -> id is section_() ), ->
          'a'._ '!click':( -> section_ id ; false ), href:'#', -> label
      x 'login', 'Login'
      x 'signup', 'Signup'
      x 'forgot', 'Forgot Password'
    switch section_()
      when 'login' then login_ui()
      when 'signup' then signup_ui()
      when 'forgot' then forgot_ui()

email_input = ->
  '.control-group'._ '.success': email_ok, ->
    'input.input-block-level'._
      type: 'text'
      placeholder: 'Email Address'
      bind: email_

login_ui = ->
  is_valid     = -> email_ok() and password_ok()
  'h2'._ 'Sign In'
  email_input()
  '.control-group'._ '.success': password_ok, ->
    'input.input-block-level'._
      type: 'password'
      placeholder: 'Password'
      bind: password_
  'label.checkbox'._ $display:(-> if is_valid() then 'block' else 'none'), ->
    'input'._  type:"checkbox", value:"remember-me"
    'span'._ -> 'Remember Me'
  'button.btn.btn-large.btn-block'._
    '.btn-primary':   is_valid,
    disabled:         ( -> not is_valid() )
    content:          'Sign In'
    '!click':         -> alert( "logged in as " + email_() + " : " + password_() ) ; no

signup_ui = ->
  is_valid = -> email_ok()
  'h2'._ 'Signup'
  email_input()
  'button.btn.btn-large.btn-block'._
    '.btn-primary':   is_valid,
    disabled:         ( -> not is_valid() )
    content:          'Signup'

forgot_ui = ->
  is_valid = -> email_ok()
  'h2'._ -> 'Forgot Password'
  email_input()
  'button.btn.btn-large.btn-block'._
    '.btn-primary':   is_valid,
    disabled:         ( -> not is_valid() )
    content:          'Reset Password'

email_re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

