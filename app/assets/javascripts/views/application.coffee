#prepare section by https://github.com/rafcamlet
window.prepare = (path, target = window) ->
  classes = path.split('.')
  target = target[classes.shift()] ||= {}

  return true if classes.length == 0
  prepare classes.join('.'), target

window.Views ||= {}

class Views.ApplicationView
  render: ->
    Widgets.UserForm.enable()
    $('#modal').modal()

  cleanup: ->

