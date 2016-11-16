prepare 'Views.Projects'

class Views.Projects.Index extends Views.ApplicationView

  render: ->
    super()

    store =
      state:
        projects: []

    Vue.component 'project-row',
      template: '#project-row',
      props:
        project: Object
      data: ->
        errors: {}
      methods:
        removeProject: ->
          that = this
          $.ajax
            data:
              project: that.project
            url: Routes.project_path({id: that.project.id, 'format': 'json'})
            method: 'DELETE'
        editProject: ->
          that = this
          $.ajax
            url: Routes.edit_project_path({id: that.project.id, 'format': 'json'})
            success: (data) ->
              $('#modal').html($(data))
              $('#modal').modal('open')
              view = new Views.Projects.Edit
              view.render(that.project)

    window.projects = new Vue
      el: '#projects'
      data:
        privateState: {}
        sharedState: store.state
      created: ->
        that = this
        $.ajax
          url: Routes.projects_path({'format': 'json'})
          success: (data) ->
            that.sharedState.projects = data

    new Vue
      el: '#projects-info'
      data:
        projects_count: store.state.projects.length


    new_project = new Vue
      el: '#new_project'
      methods:
        showNewForm: ->
          $.ajax
            url: Routes.new_project_path()
            success: (data) ->
              $('#modal').html($(data))
              $('#modal').modal('open')
              view = new Views.Projects.New
              view.render()


  cleanup: ->
    super()
    window.projects = undefined
