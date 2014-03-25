class CreateLessonTags < ActiveRecord::Migration
  def change
    create_table :lesson_tags do |t|
      t.references :lesson, index: true
      t.references :tag, index: true

      t.timestamps
    end
  end
end
