class EquipmentMaterial < ApplicationRecord
  belongs_to :material
  belongs_to :equipment

  validates :material, :equipment, presence: true
end
