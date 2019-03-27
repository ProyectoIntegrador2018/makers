class AddTechnicalDescriptionToEquipment < ActiveRecord::Migration[5.2]
  def change
    add_column :equipment, :technical_description, :text
  end
end
