class Material < ApplicationRecord
  has_many :equipment_materials
  has_many :equipment, through: :equipment_materials

  validates :name, presence: true
end
