class CreateProjectRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :project_relationships do |t|
      t.integer :saver_id
      t.integer :saved_id

      t.timestamps
    end
	add_index :project_relationships, :saver_id
	add_index :project_relationships, :saved_id
	add_index :project_relationships, [:saver_id, :saved_id], unique: true
  end
end
