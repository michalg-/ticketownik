class Ticket < ApplicationRecord

  belongs_to :project
  belongs_to :creator, foreign_key: :creator_id, class_name: User

  has_many :comments

  validates :title, presence: true

  delegate :name, to: :creator, prefix: true

end
