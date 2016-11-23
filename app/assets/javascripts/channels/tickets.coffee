App.tickets = App.cable.subscriptions.create 'TicketsChannel',

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
    ticket = JSON.parse(data.ticket)
    switch data.action
      when 'create'
        store.state.tickets.unshift(ticket)
      when 'update'
        store.state.tickets.splice(@getIndexOfObject(ticket), 1, ticket)
      when 'destroy'
        store.state.tickets.splice(@getIndexOfObject(ticket), 1)


  followCurrentProject: ->
    if projectId = document.getElementById('project')
      @perform 'follow', project_id: projectId.getAttribute('project-id')
    else
      @perform 'unfollow'

  getIndexOfObject: (object) ->
    i = 0
    while i < store.state.tickets.length
      if store.state.tickets[i].id == object.id
        return i
      i++
