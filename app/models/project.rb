class Project < ApplicationRecord

  has_many :projects_users
  has_many :tickets, dependent: :destroy
  has_many :users, through: :projects_users

  validates :name, uniqueness: true, presence: true

end
