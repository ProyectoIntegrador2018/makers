class Lab < ApplicationRecord
  audited
  validates :name, :description, :location, :location_link, presence: true

  has_many :lab_spaces

  has_many :lab_administrations, as: :space
  has_many :admins, through: :lab_administrations
  belongs_to :user, optional: true
end
