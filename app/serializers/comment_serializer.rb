class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :author_id, :ticket_id, :editable

  def created_at
    I18n.l(object.created_at)
  end

  def editable
    CommentPolicy.new(scope, object).update?
  end

end
