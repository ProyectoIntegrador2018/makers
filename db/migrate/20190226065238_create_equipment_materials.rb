class CreateEquipmentMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :equipment_materials do |t|
      t.references :material, foreign_key: true, null: false
      t.references :equipment, foreign_key: true, null: false

      t.timestamps
    end
  end
end
