class User < ApplicationRecord
  has_secure_password

  has_many :comments, foreign_key: :author_id
  has_many :projects_users
  has_many :projects, through: :projects_users
  has_many :requested_tickets, foreign_key: :creator_id, class_name: Ticket

  has_one :photo, class_name: User::Photo, dependent: :destroy

end
