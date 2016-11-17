class Tickets::DestroyJob < ApplicationJob

  def perform(ticket, current_user)
    #parse json ticket to hash only for it's project_id
    ActionCable.server.broadcast("project:#{JSON.parse(ticket)['project_id']}:tickets",
      ticket: ticket,
      action: :destroy
    )
    ActionCable.server.broadcast("project:#{JSON.parse(ticket)['project_id']}:notifications", "Ticket removed by #{current_user.name}")
  end

end
