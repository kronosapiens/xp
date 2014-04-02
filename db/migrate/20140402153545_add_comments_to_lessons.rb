class AddCommentsToLessons < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :content
      t.integer :lesson_id

      t.timestamps
    end
  end
end
