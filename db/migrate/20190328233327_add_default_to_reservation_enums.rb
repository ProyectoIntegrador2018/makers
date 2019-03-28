class AddDefaultToReservationEnums < ActiveRecord::Migration[5.2]
  def change
    change_column_default :reservations, :status, 0
    change_column_default :reservations, :purpose, 0
  end
end
