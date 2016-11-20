App.notifications = App.cable.subscriptions.create 'UserNotificationsChannel',

  connected: ->
    that = this
    @proceedConnect(that)
    $(document).on 'turbolinks:load', ->
      that.proceedConnect(that)
    $(document).on 'turbolinks:request-start', ->
      that.perform 'unfollow'

  proceedConnect: (that) ->
    setTimeout =>
      that.perform 'follow'
    , 1000

  received: (data) ->
    console.log data
    Materialize.toast(data, 2000)
