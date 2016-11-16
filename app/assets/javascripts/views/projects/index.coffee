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
            url: Routes.api_project_path({id: that.project.id})
            dataType: 'json'
            method: 'DELETE'
        editProject: ->
          that = this
          $.ajax
            url: Routes.edit_project_path({id: that.project.id})
            success: (data) ->
              $('#modal').html($(data))
              $('#modal').modal('open')
              view = new Views.Projects.Edit
              view.render(that.project)
        showProject: ->
          Turbolinks.visit(Routes.project_path({id: this.project.id}))

    new Vue
      el: '#projects'
      data: store.state
      created: ->
        that = this
        $.ajax
          url: Routes.api_projects_path()
          dataType: 'json'
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
    window.store = undefined
