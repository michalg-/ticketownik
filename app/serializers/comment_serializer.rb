class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :author, :ticket_id

  def created_at
    I18n.l(object.created_at)
  end

  def author
    {
      id: object.author_id,
      name: object.author_name
    }
  end
end
