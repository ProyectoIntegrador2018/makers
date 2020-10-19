class AddRulesToEquipment < ActiveRecord::Migration[5.2]
  def change
    add_column :equipment, :max_usage, :integer
    add_column :equipment, :rest_time, :integer
  end
end
