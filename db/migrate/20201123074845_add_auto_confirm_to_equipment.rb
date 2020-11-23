class AddAutoConfirmToEquipment < ActiveRecord::Migration[5.2]
  def change
    add_column :equipment, :auto_confirm, :boolean,:default=>false
  end
end
