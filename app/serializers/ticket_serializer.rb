class TicketSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :creator, :status

  def created_at
    I18n.l(object.created_at)
  end

  def creator
    {
      id: object.creator_id,
      name: object.creator_name
    }
  end
end
