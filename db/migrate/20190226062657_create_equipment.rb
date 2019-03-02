class CreateEquipment < ActiveRecord::Migration[5.2]
  def change
    create_table :equipment do |t|
      t.string :name, null: false
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
