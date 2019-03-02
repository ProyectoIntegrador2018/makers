class Equipment < ApplicationRecord
  has_many :equipment_materials, dependent: :destroy
  has_many :materials, through: :equipment_materials
  has_many :equipment_capabilities, dependent: :destroy
  has_many :capabilities, through: :equipment_capabilities
  belongs_to :lab_space

  validates :name, :description, :lab_space, presence: true
end
