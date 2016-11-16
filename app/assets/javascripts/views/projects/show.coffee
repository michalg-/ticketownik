prepare 'Views.Projects'

class Views.Projects.Show extends Views.ApplicationView

  render: ->
    super()

    window.store = new Vuex.Store(
      state:
        project: {}
        tickets: []
    )
    $.ajax
      url: Routes.project_tickets_path({project_id: project.getAttribute('project-id')})
      dataType: 'json'
      success: (data) ->
        Vue.set(store.state, 'tickets', data)

    Vue.component 'ticket-row',
      template: '#ticket-row',
      props:
        ticket: Object
      data: ->
        show_description: false
        errors: {}
      methods:
        showDescription: ->
          return if this.ticket.description.length <= 0
          this.show_description = !this.show_description

    new Vue
      el: '#project'
      data: store.state
      computed:
        id: ->
          document.getElementById('project').getAttribute('project-id')
      created: ->
        that = this
        $.ajax
          url: Routes.api_project_path({id: that.id})
          dataType: 'json'
          success: (data) ->
            Vue.set(store.state, 'project', data)

    new Vue
      el: '#done-tickets'
      data: store.state
      computed:
        ticketsStatusDone: ->
          store.state.tickets.filter((ticket) -> ticket.status == 'done')

    new Vue
      el: '#waiting-tickets'
      data: store.state
      computed:
        ticketsStatusWaiting: ->
          store.state.tickets.filter((ticket) -> ticket.status == 'waiting')

    new Vue
      el: '#icebox-tickets'
      data: store.state
      computed:
        ticketsStatusIcebox: ->
          store.state.tickets.filter((ticket) -> ticket.status == 'icebox')



  cleanup: ->
    super()
    window.store = undefined

