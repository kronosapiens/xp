class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.references :user, index: true
      t.references :tag, index: true
      t.integer :taken, default: 0
      t.integer :taught, default: 0
      t.integer :gh_stat, default: 0

      t.timestamps
    end
  end
end
