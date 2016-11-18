App.notifications = App.cable.subscriptions.create 'NotificationsChannel',

  connected: ->
    that = this
    @proceedConnect(that)
    $(document).on 'turbolinks:load', ->
      that.proceedConnect(that)
    $(document).on 'turbolinks:request-start', ->
      that.perform 'unfollow'

  proceedConnect: (that) ->
    setTimeout =>
      that.followCurrentProject()
    , 1000

  received: (data) ->
    Materialize.toast(data, 2000)


  followCurrentProject: ->
    if projectId = document.getElementById('project')
      @perform 'follow', project_id: projectId.getAttribute('project-id')
    else
      @perform 'unfollow'
