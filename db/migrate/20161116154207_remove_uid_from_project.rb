class RemoveUidFromProject < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :uid, :string
  end
end
