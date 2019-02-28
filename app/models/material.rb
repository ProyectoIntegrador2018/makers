class Material < ApplicationRecord
  has_many :equipment_materials
  has_many :equipment, through: :equipment_materials

  validates :name, presence: true

  def destroy_unused_material
    material = Material.find_by(self.material)
    if material
      material.destroy
    end
  end
end
