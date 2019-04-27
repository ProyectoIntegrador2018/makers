class EquipmentCapability < ApplicationRecord
  belongs_to :capability
  belongs_to :equipment

  validates :capability, :equipment, presence: true

  def destroy_orphaned(record)
    record.capability.destroy_if_orphaned
  end
end
