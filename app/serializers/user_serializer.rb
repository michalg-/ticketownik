class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :photo

  cache

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
end
