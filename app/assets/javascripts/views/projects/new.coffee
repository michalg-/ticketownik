prepare 'Views.Projects'

class Views.Projects.New extends Views.ApplicationView

  render: ->
    super()
    new Vue
      el: '#project-form'
      data:
        project:
          name: ''
          description: ''
        errors: {}
      methods:
        submitProject: ->
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

