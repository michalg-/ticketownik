App.comments = App.cable.subscriptions.create 'CommentsChannel',

  connected: ->
    that = this
    @proceedConnect(that)
    $(document).on 'turbolinks:load', ->
      that.proceedConnect(that)

  proceedConnect: (that) ->
    console.log 'łączę'
    setTimeout =>
      that.followCurrentProject()
    , 1000

  received: (data) ->
    comment = JSON.parse(data.comment)
    switch data.action
      when 'create'
        store.state.tickets[@getIndexOfObject(comment)].comments.push(comment)

  followCurrentProject: ->
    console.log 'paczam'
    if projectId = document.getElementById('project')
      @perform 'follow', project_id: projectId.getAttribute('project-id')
    else
      @perform 'unfollow'

  getIndexOfObject: (object) ->
    i = 0
    while i < store.state.tickets.length
      if store.state.tickets[i].id == object.ticket_id
        return i
      i++
