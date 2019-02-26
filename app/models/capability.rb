class Capability < ApplicationRecord
  has_many :equipment_capabilities
  has_many :equipment, through: :equipment_capabilities

  validates :name, presence: true
end
