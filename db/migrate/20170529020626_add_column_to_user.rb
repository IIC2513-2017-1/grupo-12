class AddColumnToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :wallet, :integer, default: 0
  end
end
