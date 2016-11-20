prepare 'Views.Users'

class Views.Users.Edit extends Views.ApplicationView

  render: (user) ->
    that = this
    new Vue
      el: '#user-form'
      data:
        user:
          email: user.email
          name: user.name
          photo: user.photo
        errors: {}
      methods:
        submitUser: ->
          formData = new FormData()
          formData.append('user[name]', @user.name)
          formData.append('user[photo]', (document.getElementById('user-photo').files[0] || ''))
          $.ajax
            method: 'PATCH'
            url: Routes.api_user_path()
            processData: false
            contentType: false
            data: formData
            success: (data) ->
              $('#modal').modal('close')
            error: (data) ->
              that.errors = data.responseJSON.errors

    $('#modal .input-field label').addClass('active')


  cleanup: ->
