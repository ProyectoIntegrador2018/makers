class CreateEquipmentCapabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :equipment_capabilities do |t|
      t.references :capability, foreign_key: true, null: false
      t.references :equipment, foreign_key: true, null: false

      t.timestamps
    end
  end
end
