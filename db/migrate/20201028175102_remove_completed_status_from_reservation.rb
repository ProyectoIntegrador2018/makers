class RemoveCompletedStatusFromReservation < ActiveRecord::Migration[5.2]
  def change
    # Remove all records with value "3" (i.e. completed)
    execute "DELETE FROM reservations WHERE status = 3;"
    # Since completed enum value is 3, move all values above it down by one
    execute "UPDATE reservations SET status = 3 WHERE status = 4;" # cancelled
    execute "UPDATE reservations SET status = 4 WHERE status = 5;" # blocked
  end
end
