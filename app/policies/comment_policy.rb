class CommentPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    record.author_id == user.id
  end

  def update?
    record.author_id == user.id
  end

  def destroy?
    record.author_id == user.id
  end
end
