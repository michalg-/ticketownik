class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :author, :ticket_id, :editable

  def created_at
    I18n.l(object.created_at)
  end

  def author
    UserSerializer.new(object.author)
  end

  def editable
    scope.id == object.author_id
  end

end
