class Tickets::CreateJob < ApplicationJob

  def perform(ticket, current_user)
    ActionCable.server.broadcast("project:#{ticket.project_id}:tickets",
      ticket: TicketSerializer.new(ticket).to_json,
      action: :create
    )
    ActionCable.server.broadcast("project:#{ticket.project_id}:notifications", "Ticket added by #{current_user.name}")
  end

end
