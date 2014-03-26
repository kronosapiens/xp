class CreateUserLessons < ActiveRecord::Migration
  def change
    create_table :user_lessons do |t|
      t.references :user, index: true
      t.references :lesson, index: true
      t.string :role

      t.timestamps
    end
  end
end
