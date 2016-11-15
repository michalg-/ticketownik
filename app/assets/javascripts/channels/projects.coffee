App.projects = App.cable.subscriptions.create 'ProjectsChannel',

  received: (data) ->
    if $('body[js-class-name="Views.Projects.Index"] #projects').length > 0
      $.ajax
        url: Routes.projects_path({format: 'json'})
        success: (data) ->
          Vue.set(projects, 'projects', data)

