class LabAdministration < ApplicationRecord
  audited
  belongs_to :admin, class_name: 'User'
  belongs_to :space, polymorphic: true
end
