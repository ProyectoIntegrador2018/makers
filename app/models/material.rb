class Material < ApplicationRecord
  has_many :equipment_materials
  has_many :equipment, through: :equipment_materials
  scope :orphaned, -> { left_outer_joins(:equipment_materials).where(equipment_materials: {id: nil}) }

  validates :name, presence: true
end
