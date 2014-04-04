class AddSpecificTimeAndSpecificLocationToLessons < ActiveRecord::Migration
  def change  
    add_column :lessons, :specific_time, :string
    add_column :lessons, :specific_location, :string
  end
end
