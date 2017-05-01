class CreateCategorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :categorizations do |t|
      t.integer :project_id
      t.integer :category_id

      t.timestamps
    end
    add_index :categorizations, %i[project_id category_id], unique: true
  end
end
