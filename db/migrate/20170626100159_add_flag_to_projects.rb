class AddFlagToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :achieved, :boolean, default: false
  end
end
