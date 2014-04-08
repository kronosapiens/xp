class AddSlugToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :slug, :string
  end
end
