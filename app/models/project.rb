class Project < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  has_many :tickets, dependent: :destroy

end
