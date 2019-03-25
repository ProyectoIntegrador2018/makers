class Equipment < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many :equipment_materials, dependent: :destroy
  has_many :materials, through: :equipment_materials
  has_many :equipment_capabilities, dependent: :destroy
  has_many :capabilities, through: :equipment_capabilities
  has_many :available_hours
  has_many :reservations
  belongs_to :lab_space

  validates :name, :description, :lab_space, presence: true

  def self.search(name)
    if name.present?
      where('equipment.name ILIKE ?', "%#{name}%")
    else
      Equipment.all
    end
  end

  def self.search_by(relation, query)
    if query.present?
      names = query.split(/[,\s]+/)
      joins(relation).where(relation => { name: names }).distinct
    else
      Equipment.all
    end
  end
end
