class CreateAvailableHours < ActiveRecord::Migration[5.2]
  def change
    create_table :available_hours do |t|
      t.time :start_time
      t.time :end_time
      t.integer :day_of_week
      t.references :equipment, foreign_key: true

      t.timestamps
    end
  end
end
