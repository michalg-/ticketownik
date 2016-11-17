prepare 'Views.Tickets'

class Views.Tickets.New extends Views.ApplicationView

  render: ->
    super()
    new Vue
      el: '#ticket-form'
      data:
        ticket:
          title: ''
          description: ''
          priority: '1'
        errors: {}
      methods:
        submitTicket: ->
          that = this
          $.ajax
            method: 'POST'
            url: Routes.api_project_tickets_path({project_id: store.state.project.id})
            dataType: 'json'
            data:
              ticket:
                that.ticket
            success: (data) ->
              $('#modal').modal('close')

            error: (data) ->
              that.errors = data.responseJSON.errors

  cleanup: ->
    super()

