class Projects::CreateJob < ApplicationJob

  def perform(project)
    ActionCable.server.broadcast('projects',
      project: project,
      action: :create
    )
  end

end
