class NotificationsChannel < ApplicationCable::Channel

  def follow(data)
    stop_all_streams
    stream_from "project:#{data['project_id'].to_i}:notifications"
  end

  def unfollow
    stop_all_streams
  end

end
