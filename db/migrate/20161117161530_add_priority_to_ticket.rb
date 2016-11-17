class AddPriorityToTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :priority, :integer, default: 1
  end
end
