class AddReservationsCountToEquipment < ActiveRecord::Migration[5.2]
  def change
    add_column :equipment, :reservations_count, :integer, default: 0
  end
end
