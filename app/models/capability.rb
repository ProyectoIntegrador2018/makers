class Capability < ApplicationRecord
  has_many :equipment_capabilities
  has_many :equipment, through: :equipment_capabilities
  scope :orphaned, -> { left_outer_joins(:equipment_capabilities).where(equipment_capabilities: { id: nil }) }

  validates :name, presence: true
end
