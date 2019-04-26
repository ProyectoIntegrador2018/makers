class Lab < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :name, :description, :location, presence: true

  belongs_to :creator, class_name: 'User'
  has_many :lab_spaces

  has_many :lab_administrations, as: :space
  has_many :admins, through: :lab_administrations
end
