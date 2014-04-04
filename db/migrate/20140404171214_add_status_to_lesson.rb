class AddStatusToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :status, :string, :default => "open"
  end
end
