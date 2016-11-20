class TicketSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :creator_id, :status, :color,
    :priority, :comments

  def color
    case object.priority
    when 1 then ''
    when 2 then 'orange lighten-5'
    when 3 then 'red lighten-5'
    end
  end

  def comments
    object.comments.preload(:author).
      map{ |comment| CommentSerializer.new(comment, scope: scope ) }
  end

  def created_at
    I18n.l(object.created_at)
  end

  def priority
    object.priority.to_s
  end
end
