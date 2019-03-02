class Lab < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :name, :description, :location, presence: true

  has_many :lab_spaces
end
