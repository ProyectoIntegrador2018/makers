class EquipmentCapability < ApplicationRecord
  belongs_to :capability
  belongs_to :equipment

  validates :capability, :equipment, presence: true
end
