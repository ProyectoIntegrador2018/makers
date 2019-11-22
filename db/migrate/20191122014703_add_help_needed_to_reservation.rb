class AddHelpNeededToReservation < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :help_needed, :boolean
  end
end
