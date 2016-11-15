prepare 'Views.Projects'

class Views.Projects.Index extends Views.ApplicationView

  render: ->
    super()
    projects = new Vue
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


  cleanup: ->
    super()

