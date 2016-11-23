class ProjectPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    true
  end

  def update?
    user.projects_users.assigned.exists?(project_id: record.id)
  end

  def destroy?
    user.projects_users.assigned.exists?(project_id: record.id)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.joins(:projects_users).
        where(projects_users: { user_id: user.id, state: :assigned })
    end
  end
end
