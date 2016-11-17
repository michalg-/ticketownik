prepare 'Views.Tickets'

class Views.Tickets.Edit extends Views.ApplicationView

  render: (ticket) ->
    super()
    new Vue
      el: '#ticket-form'
      data:
        ticket:
          title: ticket.title
          description: ticket.description
          priority: ticket.priority
        errors: {}
      methods:
        submitTicket: ->
          that = this
          $.ajax
            method: 'PATCH'
            url: Routes.api_project_ticket_path({project_id: store.state.project.id, id: ticket.id, _options: true})
            dataType: 'json'
            data:
              ticket:
                that.ticket
            success: (data) ->
              $('#modal').modal('close')
            error: (data) ->
              that.errors = data.responseJSON.errors

    $('#modal .input-field label').addClass('active')
  cleanup: ->
    super()

