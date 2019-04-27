class EquipmentCapability < ApplicationRecord
  belongs_to :capability
  belongs_to :equipment
  validates :capability, :equipment, presence: true
  after_destroy :destroy_orphaned

  def destroy_orphaned
    material.destroy_if_orphaned
  end
end
