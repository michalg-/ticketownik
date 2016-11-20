class Users::UpdateJob < ApplicationJob

  def perform(user)
    #for now there is no option to register to preojects, to send to every
    Project.all.each do |project|
      ActionCable.server.broadcast("project:#{project.id}:notifications",
        user: UserSerializer.new(user),
        action: :user_update
      )
    end
  end

end
