class LabSpace < ApplicationRecord
  validates :name, :description, :location, :lab, presence: true

  belongs_to :lab
end
