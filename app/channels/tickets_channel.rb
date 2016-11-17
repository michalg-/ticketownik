class TicketsChannel < ApplicationCable::Channel

  def follow(data)
    stop_all_streams
    stream_from "project:#{data['project_id'].to_i}:tickets"
  end

  def unfollow
    stop_all_streams
  end

end
