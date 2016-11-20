prepare 'Views.Projects'

class Views.Projects.Edit extends Views.ApplicationView

  render: (project) ->
    new Vue
      el: '#project-form'
      data:
        project:
          id: project.id
          name: project.name
          description: project.description
        errors: {}
      methods:
        submitProject: ->
          that = this
          $.ajax
            method: 'PATCH'
            url: Routes.api_project_path({id: that.project.id})
            dataType: 'json'
            data:
              project:
                that.project
            success: (data) ->
              $('#modal').modal('close')

            error: (data) ->
              that.errors = data.responseJSON.errors

  cleanup: ->

