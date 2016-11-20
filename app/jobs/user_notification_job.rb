class UserNotificationJob < ApplicationJob

  def perform(content, user)
    ActionCable.server.broadcast("user:#{user.id}:notifications",content)
  end

end
