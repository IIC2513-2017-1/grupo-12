class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.text :brief, null: false
      t.text :description
      t.date :funding_duration, null:false
      t.integer :funding_goal, null:false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
