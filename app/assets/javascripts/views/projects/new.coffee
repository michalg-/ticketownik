prepare 'Views.Projects'

class Views.Projects.New extends Views.ApplicationView

  render: ->
    super()
    project = new Vue
      el: '#new_project_form'
      data:
        project:
          name: ''
          description: ''
        errors: {}
      methods:
        createProject: ->
          that = this
          $.ajax
            method: 'POST'
            url: Routes.projects_path({format: 'json'})
            data:
              project:
                that.project
            success: (data) ->
              $('#modal').modal('close')

            error: (data) ->
              that.errors = data.responseJSON.errors

  cleanup: ->
    super()

