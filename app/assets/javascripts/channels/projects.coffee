App.projects = App.cable.subscriptions.create 'ProjectsChannel',

  received: (data) ->
    switch data.action
      when 'create', 'update'
        if $('body[js-class-name="Views.Projects.Index"] #projects').length > 0
          $.ajax
            url: Routes.api_projects_path({format: 'json'})
            success: (data) ->
              Vue.set(store.state, 'projects', data)
      when 'destroy'
        store.state.projects.splice(@getIndexOfObject(JSON.parse(data.project)), 1)

  getIndexOfObject: (object) ->
    i = 0
    while i < store.state.projects.length
      if store.state.projects[i].id == object.id
        return i
      i++
