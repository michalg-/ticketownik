class Projects::DestroyJob < ApplicationJob

  def perform
    ActionCable.server.broadcast('projects', {})
  end

end
