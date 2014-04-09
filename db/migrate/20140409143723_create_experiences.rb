class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.references :user, index: true
      t.references :tag, index: true
      t.integer :taken
      t.integer :taught
      t.integer :gh_stat

      t.timestamps
    end
  end
end
