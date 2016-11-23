class ProjectsUser < ApplicationRecord

  belongs_to :project
  belongs_to :user, touch: true

  validates :user_id, uniqueness: { scope: :project_id }

end
