class Equipment < ApplicationRecord
  validates :name, :description, presence: true
end
