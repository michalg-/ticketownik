class AddStateToProjectsUser < ActiveRecord::Migration[5.0]
  def change
    add_column :projects_users, :state, :string, default: :assigned
  end
end
