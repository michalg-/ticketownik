App.projects = App.cable.subscriptions.create 'ProjectsChannel',

  received: (data) ->
    switch data.action
      when 'create', 'update'
        if $('body[js-class-name="Views.Projects.Index"] #projects').length > 0
          $.ajax
            url: Routes.projects_path({format: 'json'})
            success: (data) ->
              Vue.set(store.state, 'projects', data)
      when 'destroy'
        project = JSON.parse(data.project)
        i = 0
        while i < store.state.projects.length
          if store.state.projects[i].id == project.id
            store.state.projects.splice(i, 1)
            return
          i++


