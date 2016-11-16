prepare 'Views.Projects'

class Views.Projects.Edit extends Views.ApplicationView

  render: (project) ->
    super()
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
            url: Routes.project_path({id: that.project.id, format: 'json'})
            data:
              project:
                that.project
            success: (data) ->
              $('#modal').modal('close')

            error: (data) ->
              that.errors = data.responseJSON.errors

  cleanup: ->
    super()

