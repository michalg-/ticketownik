class ProjectsChannel < ApplicationCable::Channel

  def follow
    stop_all_streams
    stream_from 'projects'
  end

  def unfollow
    stop_all_streams
  end

end
