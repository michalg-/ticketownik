App.projects = App.cable.subscriptions.create 'ProjectsChannel',

  connected: ->
    console.log 'connected'
    setTimeout =>
      @followProjects()
      $(document).on 'turbolinks:load', -> App.projects.followProjects()

  received: (data) ->
    console.log data

  followProjects: ->
    perform 'follow'
