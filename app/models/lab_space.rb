class LabSpace < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :name, :description, :location, :lab, presence: true

  belongs_to :lab
  has_many :equipment
end
