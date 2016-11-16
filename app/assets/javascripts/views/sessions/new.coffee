prepare 'Views.Sessions'

class Views.Sessions.New extends Views.ApplicationView

  render: ->
    super()
    login_form = new Vue
      el: '#login-form'
      data:
        user:
          email: ''
          password: ''
        errors: {}
      methods:
        createSession: ->
          that = this
          $.ajax
            method: 'POST'
            url: Routes.api_sessions_path()
            dataType: 'json'
            data:
              user:
                that.user
            success: (data) ->
              Turbolinks.visit(Routes.projects_path())

            error: (data) ->
              that.errors = data.responseJSON.errors

  cleanup: ->
    super()

