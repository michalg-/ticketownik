#= require jquery
#= require jquery_ujs
#= require vue
#= require vuex
#= require turbolinks
#= require js-routes
#= require materialize-sprockets

#= require_tree ./widgets
#= require_tree ./views
#= require ./channels/index


$(document).on 'turbolinks:load', ->
  className = $('body').attr('js-class-name')
  window.applicationView = try
    eval("new #{className}()")
  catch error
    new Views.ApplicationView()
  window.applicationView.render()

$(document).on 'turbolinks:before-render', ->
  window.applicationView.cleanup()
