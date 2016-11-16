class ProjectsChannel < ApplicationCable::Channel

  def subscribed
    stream_from 'projects'
  end

  def unsubscribed
    stop_all_streams
  end

end
