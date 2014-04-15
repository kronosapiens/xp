class AddLevelToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :level, :integer
  end
end
