class Capability < ApplicationRecord
  has_many :equipment_capabilities
  has_many :equipment, through: :equipment_capabilities

  validates :name, presence: true, uniqueness: true

  def destroy_if_orphaned
    destroy if equipment_capabilities.empty?
  end
end
