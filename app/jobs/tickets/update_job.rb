class Tickets::UpdateJob < ApplicationJob

  def perform(ticket, current_user)
    ActionCable.server.broadcast("project:#{ticket.project_id}:tickets",
      ticket: TicketSerializer.new(ticket).to_json,
      action: :update
    )
    ActionCable.server.broadcast("project:#{ticket.project_id}:notifications", "Ticket updated by #{current_user.name}")
  end

end
