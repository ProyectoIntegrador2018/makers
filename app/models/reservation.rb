class Reservation < ApplicationRecord
  enum status: [:arrived, :pending, :cancelled, :blocked]

  belongs_to :equipment
  belongs_to :user
end
