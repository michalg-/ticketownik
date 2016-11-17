class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :author_id
      t.text :content
      t.integer :ticket_id

      t.timestamps
    end
    add_index :comments, :author_id
    add_index :comments, :ticket_id
  end
end
