class AddAdminToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :admin, :boolean, :default => false
  end
end