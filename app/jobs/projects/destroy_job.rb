class Projects::DestroyJob < ApplicationJob

  def perform(project)
    ActionCable.server.broadcast('projects',
      project: project,
      action: :destroy
    )
  end

end
