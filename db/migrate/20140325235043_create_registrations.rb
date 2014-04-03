class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.references :user, index: true
      t.references :lesson, index: true
      t.string :role

      t.timestamps
    end
  end
end
