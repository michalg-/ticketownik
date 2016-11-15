prepare 'Views.Projects'

class Views.Projects.Index extends Views.ApplicationView

  render: ->
    super()

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

    window.projects = new Vue
      el: '#projects'
      data: {
        projects: []
      }
      created: ->
        that = this
        $.ajax
          url: Routes.projects_path({'format': 'json'})
          success: (data) ->
            that.projects = data

    new_project = new Vue
      el: '#new_project'
      methods:
        showNewForm: ->
          $.ajax
            url: Routes.new_project_path()
            success: (data) ->
              console.log data
              $('#modal').html($(data))
              $('#modal').modal('open')
              view = new Views.Projects.New
              view.render()


  cleanup: ->
    super()
    window.projects = undefined
