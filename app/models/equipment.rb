class Equipment < ApplicationRecord
  has_many :equipment_materials
  has_many :materials, through: :equipment_materials

  validates :name, :description, presence: true
end
