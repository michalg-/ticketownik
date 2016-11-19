class Comments::CreateJob < ApplicationJob

  def perform(ticket, comment, current_user)
    ActionCable.server.broadcast("project:#{ticket.project_id}:tickets:comments",
      comment: CommentSerializer.new(comment, scope: current_user).to_json,
      action: :create
    )
    ActionCable.server.broadcast("project:#{ticket.project_id}:notifications", "Comment added by #{current_user.name}")
  end

end
