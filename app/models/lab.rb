class Lab < ApplicationRecord
  validates :name, :description, :location, presence: true

  has_many :lab_spaces
end
