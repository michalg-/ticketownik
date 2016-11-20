class User::Photo < ApplicationRecord
  include User::PhotoUploader[:asset]

  belongs_to :user, touch: true

end
