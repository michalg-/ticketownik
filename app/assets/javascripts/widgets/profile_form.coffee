window.Widgets ||= {}

class Widgets.UserForm

  @enable: ->
    widget = this
    new Vue
      el: '#user-profile-link'
      data:
        user: {}
        errors: {}
      methods:
        showUserForm: ->
          that = this
          $.ajax
            url: Routes.api_user_path()
            success: (data) ->
              that.user = data
              widget.showUserProfileModal(that)

  @cleanup: ->

  @showUserProfileModal: (that) ->
    $.ajax
      url: Routes.edit_user_path()
      success: (data) ->
        $('#modal').html($(data))
        $('#modal').modal('open')
        new Views.Users.Edit().render(that.user)
