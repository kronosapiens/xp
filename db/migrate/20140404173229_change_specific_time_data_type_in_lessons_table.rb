class ChangeSpecificTimeDataTypeInLessonsTable < ActiveRecord::Migration
  def change
    change_column :lessons, :specific_time, :datetime
  end
end
