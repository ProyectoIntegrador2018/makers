class Material < ApplicationRecord
  has_many :equipment_materials
  has_many :equipment, through: :equipment_materials

  validates :name, presence: true, uniqueness: true

  def destroy_if_orphaned
    destroy if equipment_materials.empty?
  end
end
