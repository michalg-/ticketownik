class Comment < ApplicationRecord

  belongs_to :author, class_name: User
  belongs_to :ticket

  delegate :name, to: :author, prefix: true

end
