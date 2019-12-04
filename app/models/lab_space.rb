class LabSpace < ApplicationRecord
  audited
  mount_uploader :image, ImageUploader
  validates :name, :description, :location, :lab, presence: true

  belongs_to :lab
  has_many :equipment
  belongs_to :user, optional: true

  has_many :lab_administrations, as: :space
  has_many :admins, through: :lab_administrations
end
