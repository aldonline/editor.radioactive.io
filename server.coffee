express                 = require 'express'
less_middleware         = require 'less-middleware'
path                    = require 'path'
expressito              = require 'expressito'

PRODUCTION = process.env.NODE_ENV is 'production'

ACE_JS = '/ace/src-min-noconflict/ace.js'

editor_app = expressito
  base:   path.resolve __dirname
  entry:  '/editor_app'
  mount:    '/editor_app'
  js:       [ '/jquery-1.9.1.min.js', ACE_JS, '/coffee-script.js', '/bootstrap/js/bootstrap.js']
  css:      [ '/bootstrap/css/bootstrap.css', '/css/app2.css', '/styles/default.css' ]
  favicon:  '/favicon.png'
  production: PRODUCTION

PUBLIC = __dirname + '/public'

app = express()

app.configure ->

  app.use express.compress()
  app.use express.cookieParser()
  app.use express.bodyParser()
  app.use express.session secret: 'jfklas89f7dsa89fd7s0a8fd0'

  app.use less_middleware src: PUBLIC, force: ( not PRODUCTION )

  editor_app.attach app

  app.use express.static PUBLIC

app.get '/', (req, res, next) ->
  res.writeHead 302, Location: '/editor_app'
  res.end()

port = process.env.PORT or 5001
app.listen port, -> console.log 'radioactive-editor listening on port ' + port