class CreateUserPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_photos do |t|
      t.text :asset_data
      t.integer :user_id

      t.timestamps
    end
    add_index :user_photos, :user_id
  end
end
