class Reservation < ApplicationRecord
  enum status: [:arrived, :pending, :cancelled, :blocked]
  enum purpose: [:academic, :entrepreneurship, :research, :personal]

  belongs_to :equipment
  belongs_to :user
end
