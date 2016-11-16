class Projects::UpdateJob < ApplicationJob

  def perform(project)
    ActionCable.server.broadcast('projects',
      project: project,
      action: :update
    )
  end

end
