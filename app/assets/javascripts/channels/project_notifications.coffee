App.notifications = App.cable.subscriptions.create 'ProjectNotificationsChannel',

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
    that = this
    switch data.action
      when 'user_update'
        store.state.users.splice(that.getIndexOfUser(data.user.id), 1, data.user)
      when 'message'
        Materialize.toast(data, 2000)
      else
        Materialize.toast(data, 2000)


  followCurrentProject: ->
    if projectId = document.getElementById('project')
      @perform 'follow', project_id: projectId.getAttribute('project-id')
    else
      @perform 'unfollow'

  getIndexOfUser: (object) ->
    i = 0
    while i < store.state.users.length
      if store.state.users[i].id == object.id
        return i
      i++
