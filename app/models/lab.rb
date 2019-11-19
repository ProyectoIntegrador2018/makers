class Lab < ApplicationRecord
  audited
  mount_uploader :image, ImageUploader
  validates :name, :description, :location, presence: true

  has_many :lab_spaces

  has_many :lab_administrations, as: :space
  has_many :admins, through: :lab_administrations
  belongs_to :user, optional: true
end
