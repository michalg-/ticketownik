class Tickets::CreateJob < ApplicationJob

  def perform(ticket)
    ActionCable.server.broadcast("project:#{ticket.project_id}:tickets",
      ticket: ticket.to_json,
      action: :create
    )
  end

end
