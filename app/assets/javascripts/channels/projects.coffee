App.projects = App.cable.subscriptions.create 'ProjectsChannel',

  received: (data) ->
    switch data.action
      when 'create', 'update'
        if $('body[js-class-name="Views.Projects.Index"] #projects').length > 0
          $.ajax
            url: Routes.projects_path({format: 'json'})
            success: (data) ->
              Vue.set(projects, 'projects', data)
      when 'destroy'
        project = JSON.parse(data.project)
        i = 0
        len = projects.projects.length
        while i < len
          if projects.projects[i].id == project.id
            projects.projects.splice(i, 1)
          i++

