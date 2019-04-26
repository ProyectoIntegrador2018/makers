class AddCreatorToEquipment < ActiveRecord::Migration[5.2]
  def change
    add_reference :equipment, :creator, foreign_key: { to_table: :users }, index: true
  end
end
