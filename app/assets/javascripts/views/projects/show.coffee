prepare 'Views.Projects'

class Views.Projects.Show extends Views.ApplicationView

  render: ->
    super()

    window.store = new Vuex.Store(
      state:
        project: {}
        tickets: []
        users: []
    )
    $.ajax
      url: Routes.api_project_users_path({project_id: projectId()})
      dataType: 'json'
      success: (data) ->
        Vue.set(store.state, 'users', data)

    $.ajax
      url: Routes.api_project_tickets_path({project_id: projectId()})
      dataType: 'json'
      success: (data) ->
        Vue.set(store.state, 'tickets', data)

    CommentRow = Vue.component 'comment-row',
      template: '#comment-row'
      props:
        comment: Object
      computed:
        author: ->
          that = this
          store.state.users.filter((author) -> author.id == that.comment.author_id)[0]
      methods:
        removeComment: ->
          $.ajax
            url: Routes.api_project_ticket_comment_path({project_id: projectId(), ticket_id: this.comment.ticket_id, id: this.comment.id, _options: true})
            dataType: 'json'
            method: 'DELETE'

    Vue.component 'ticket-row',
      template: '#ticket-row',
      components:
        comment_row: CommentRow
      props:
        ticket: Object
      data: ->
        show_description: false
        errors: {}
        comment:
          content: ''
      computed:
        creator: ->
          that = this
          store.state.users.filter((creator) -> creator.id == that.ticket.creator_id)[0]
        itemStyle: ->
          'border-left': "6px solid #{this.ticket.color}"
        itemClass: ->
          'z-depth-3': this.show_description
      methods:
        removeTicket: ->
          $.ajax
            url: Routes.api_project_ticket_path({project_id: projectId(), id: this.ticket.id, _options: true})
            dataType: 'json'
            method: 'DELETE'
        showEditForm: ->
          that = this
          $.ajax
            url: Routes.edit_project_ticket_path({project_id: projectId(), id: this.ticket.id, _options: true})
            success: (data) ->
              $('#modal').html($(data))
              $('#modal').modal('open')
              new Views.Tickets.Edit().render(that.ticket)
        showDescription: ->
          this.show_description = !this.show_description
          setTimeout(->
            $('.tooltipped', this.$el).tooltip()
          , 500)

        submitComment: ->
          that = this
          $.ajax
            method: 'POST'
            url: Routes.api_project_ticket_comments_path({project_id: projectId(), ticket_id: this.ticket.id, _options: true})
            dataType: 'json'
            data:
              comment: that.comment
            success: (data) ->
              that.comment.content = ''
              that.errors.content = ''
            error: (data) ->
              that.errors = data.responseJSON.errors

    new Vue
      el: '#add-ticket'
      methods:
        showNewForm: ->
          $.ajax
            url: Routes.new_project_ticket_path({project_id: projectId()})
            success: (data) ->
              $('#modal').html($(data))
              $('#modal').modal('open')
              new Views.Tickets.New().render()

    new Vue
      el: '#project'
      data: store.state
      computed:
        id: ->
          projectId()
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
      el: '#current-tickets'
      data: store.state
      computed:
        ticketsStatusWaiting: ->
          store.state.tickets.filter((ticket) -> ticket.status == 'current')

    new Vue
      el: '#waiting-tickets'
      data: store.state
      computed:
        ticketsStatusIcebox: ->
          store.state.tickets.filter((ticket) -> ticket.status == 'waiting')

  cleanup: ->
    super()
    window.store = undefined

  projectId = ->
    document.getElementById('project').getAttribute('project-id')

