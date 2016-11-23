App.comments = App.cable.subscriptions.create 'CommentsChannel',

  connected: ->
    that = this
    @proceedConnect(that)
    $(document).on 'turbolinks:load', ->
      that.proceedConnect(that)
    $(document).on 'turbolinks:request-start', ->
      console.log 'unfollowuję'
      that.perform 'unfollow'

  proceedConnect: (that) ->
    setTimeout =>
      that.followCurrentProject()
    , 1000

  received: (data) ->
    comment = JSON.parse(data.comment)
    switch data.action
      when 'create'
        that = this
        $.ajax
          url: Routes.api_project_ticket_comment_path
            project_id: document.getElementById('project').getAttribute('project-id')
            ticket_id: comment.ticket_id
            id: comment.id
            _options: true
          success: (data) ->
            store.state.tickets[that.getIndexOfObject(comment.ticket_id, store.state.tickets)]
              .comments.push(data)
            setTimeout ->
              $('.tooltipped:not(div[data-tooltip-id])').tooltip()
            , 500
      when 'destroy'
        ticket_index = @getIndexOfObject(comment.ticket_id, store.state.tickets)
        store.state.tickets[ticket_index].comments
          .splice(@getIndexOfObject(comment.id, store.state.tickets[ticket_index].comments), 1)


  followCurrentProject: ->
    if projectId = document.getElementById('project')
      @perform 'follow', project_id: projectId.getAttribute('project-id')
    else
      @perform 'unfollow'

  getIndexOfObject: (object_id, array) ->
    i = 0
    while i < array.length
      if array[i].id == object_id
        return i
      i++
