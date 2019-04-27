class EquipmentMaterial < ApplicationRecord
  belongs_to :material
  belongs_to :equipment
  validates :material, :equipment, presence: true
  after_destroy ->(record) { destroy_orphaned(record) }

  def destroy_orphaned(record)
    record.material.destroy_if_orphaned
  end
end
