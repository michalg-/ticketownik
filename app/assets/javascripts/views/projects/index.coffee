prepare 'Views.Projects'

class Views.Projects.Index extends Views.ApplicationView

  render: ->
    super()

    window.store = new Vuex.Store(
      state:
        projects: []
    )

    Vue.component 'project-row',
      template: '#project-row',
      props:
        project: Object
        index: Number
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

    new Vue
      el: '#projects'
      data: store.state
      created: ->
        that = this
        $.ajax
          url: Routes.projects_path({'format': 'json'})
          success: (data) ->
            Vue.set(store.state, 'projects', data)

    new Vue
      el: '#projects-info'
      data: store.state
      computed:
        count: ->
          this.projects.length

    new Vue
      el: '#new-project'
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
