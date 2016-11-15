class Project < ApplicationRecord
  validates :name, uniqueness: true, presence: true

end
