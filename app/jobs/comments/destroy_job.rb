class Comments::DestroyJob < ApplicationJob

  def perform(ticket, comment, current_user)
    ActionCable.server.broadcast("project:#{ticket.project_id}:tickets:comments",
      comment: comment,
      action: :destroy
    )
    ActionCable.server.broadcast("project:#{ticket.project_id}:notifications", "Comment removed by #{current_user.name}")
  end

end
