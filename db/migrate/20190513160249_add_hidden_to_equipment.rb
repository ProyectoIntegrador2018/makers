class AddHiddenToEquipment < ActiveRecord::Migration[5.2]
  def change
    add_column :equipment, :hidden, :boolean, :default => false
  end
end
