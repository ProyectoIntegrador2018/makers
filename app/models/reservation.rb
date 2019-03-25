class Reservation < ApplicationRecord
  enum status: [:arrived, :pending, :cancelled]
  enum type: [:normal, :block, :cancelled]

  belongs_to :equipment
  belongs_to :user
end
