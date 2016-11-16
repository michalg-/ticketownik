class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.integer :project_id
      t.integer :creator_id
      t.string :title
      t.text :description

      t.timestamps
    end
    add_index :tickets, :project_id
    add_index :tickets, :creator_id
  end
end
