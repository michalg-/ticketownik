class User < ApplicationRecord
  has_secure_password

  has_many :comments, foreign_key: :author_id
  has_many :requested_tickets, foreign_key: :creator_id, class_name: Ticket

end
