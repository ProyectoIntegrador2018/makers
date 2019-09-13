class AddAdminToLabs < ActiveRecord::Migration[5.2]
  def change
    add_reference :labs, :user, index: true
    add_reference :lab_spaces, :user, index: true
  end
end
