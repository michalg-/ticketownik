class Project < ApplicationRecord

  has_many :projects_users, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :users, through: :projects_users

  validates :name, presence: true

end
