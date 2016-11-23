class Projects::Users::UnassignJob < ApplicationJob

  def perform(project_id, users, current_user)
    ActionCable.server.broadcast("project:#{project_id}:notifications",
      users: users.map { |user| UserSerializer.new(user) },
      action: :users_unassign
    )
    ActionCable.server.broadcast("project:#{project_id}:notifications", "Users unassinged by #{current_user.name}")
  end

end
