class ProjectRelayJob < ApplicationJob

  def perform(project)
    ActionCable.server.broadcast('projects',
      project: project.to_json
    )
  end

end
