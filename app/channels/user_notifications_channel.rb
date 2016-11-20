class UserNotificationsChannel < ApplicationCable::Channel

  def follow(data)
    stop_all_streams
    stream_from "user:#{current_user.id}:notifications"
  end

  def unfollow
    stop_all_streams
  end

end
