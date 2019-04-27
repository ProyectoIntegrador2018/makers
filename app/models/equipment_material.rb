class EquipmentMaterial < ApplicationRecord
  belongs_to :material
  belongs_to :equipment
  validates :material, :equipment, presence: true
  after_destroy :destroy_orphaned

  def destroy_orphaned
    material.destroy_if_orphaned
  end
end
