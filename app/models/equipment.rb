class Equipment < ApplicationRecord
  has_many :equipment_materials
  has_many :materials, through: :equipment_materials
  has_many :equipment_capabilities
  has_many :capabilities, through: :equipment_capabilities

  validates :name, :description, presence: true
end
