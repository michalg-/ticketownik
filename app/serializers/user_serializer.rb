class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :photo

  #project_state for project#show view
  attribute :project_state, if: -> { instance_options[:project_id].present? }

  def photo
    if object.photo.nil?
      {
        assets: {
          original: '/face.png',
          big: '/face.png',
          chip: '/face.png'
        }
      }
    else
      User::PhotoSerializer.new(object.photo)
    end
  end

  def project_state
    object.projects_users.find_by(project_id: instance_options[:project_id]).state
  end
end
