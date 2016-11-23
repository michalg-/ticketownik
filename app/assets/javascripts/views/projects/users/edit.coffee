prepare 'Views.Projects.Users'

class Views.Projects.Users.Edit extends Views.ApplicationView

  render: ->
    userChip = Vue.component 'user-chip',
      template: '#user-chip',
      props:
        user: Object
        index: Number
      data: ->
        to_remove: false
      methods:
        addToRemoveList: (index) ->
          store.state.users_to_remove.push(this.user)
          this.to_remove = true
        removeFromRemoveList: (index) ->
          store.state.users_to_remove.splice(store.state.users_to_remove.indexOf(this.user), 1)
          this.to_remove = false

    Vue.component 'user-row',
      template: '#user-row',
      props:
        user: Object
        index: Number
      components:
        user_chip: userChip

    new Vue
      el: '#project-users-form'
      data: store.state
      computed:
        assigned_users: ->
          store.state.users.filter (user) ->
            user.project_state == 'assigned'
      methods:
        submitProjectUsers: ->
          that = this
          $.ajax
            url: Routes.api_project_users_path({id: that.project.id})
            method: 'DELETE'
            dataType: 'json'
            data:
              projects_users:
                user_ids: store.state.users_to_remove.map((user) -> user.id)
            success: (data) ->
              $('#modal').modal('close')

            error: (data) ->
              that.errors = data.responseJSON.errors

  cleanup: ->

