class UserTraining < ApplicationRecord
  belongs_to :training
  belongs_to :user
end
