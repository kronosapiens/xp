class AddAdminToUserLessons < ActiveRecord::Migration
  def change
    add_column :user_lessons, :admin, :boolean, :default => false
  end
end
