App.projects = App.cable.subscriptions.create 'TicketsChannel',

  connected: ->
    setTimeout =>
      @followCurrentProject()
    , 1000

  received: (data) ->
    console.log 'tickets channel'
    console.log data

  followCurrentProject: ->
    if projectId = document.getElementById('project').getAttribute('project-id')
      @perform 'follow', project_id: projectId
    else
      @perform 'unfollow'
