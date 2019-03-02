class AddLabSpaceToEquipment < ActiveRecord::Migration[5.2]
  def change
    add_reference :equipment, :lab_space, foreign_key: true
  end
end
