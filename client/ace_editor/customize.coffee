module.exports = ( editor ) ->
  # http://ace.ajax.org/#nav=howto
  do ( s = editor.getSession() ) ->
    s.setUseWorker no
    s.setMode "ace/mode/coffee"
    s.setUseWrapMode no
    s.setTabSize 2
    s.setUseSoftTabs yes
  editor.setShowPrintMargin no
  editor.renderer.setShowGutter no
  #http://ace.ajax.org/build/kitchen-sink.html
  #editor.setTheme "ace/theme/xcode"
  editor.setTheme "ace/theme/monokai"