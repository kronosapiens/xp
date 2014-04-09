class AddActiveToTags < ActiveRecord::Migration
  def change
    add_column :tags, :active, :boolean, :default => false
  end
end
