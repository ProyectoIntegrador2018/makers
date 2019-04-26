class Training < ApplicationRecord
  belongs_to :equipment

  has_many :user_trainings, dependent: :destroy
  has_many :users, through: :user_trainings
end
