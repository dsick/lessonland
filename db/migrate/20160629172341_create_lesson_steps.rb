class CreateLessonSteps < ActiveRecord::Migration
  def change
    create_table :lesson_steps do |t|
      t.references :lesson, index: true, foreign_key: true
      t.integer :sort_order
      t.string :photo
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
