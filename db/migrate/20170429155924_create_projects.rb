class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.text :brief
      t.text :description
      t.datetime :funding_duration
      t.integer :funding_goal
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
