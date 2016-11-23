class Api::Projects::Create < Struct.new(:project, :current_user)
  def process
    ActiveRecord::Base.transaction do
      project.save!
      project.users << current_user
    end
    ::Projects::CreateJob.perform_later(project)
  end
end
