class LabAdministration < ApplicationRecord
  belongs_to :admin, class_name: 'User'
  belongs_to :space, polymorphic: true

  validate :matches_role

  def matches_role
    errors.add(:admin, 'cannot be user') if admin.user?
    errors.add(:admin, 'cannot be superadmin, it already has all privileges') if admin.superadmin?
    errors.add(:admin, 'expected to be admin, not lab admin') if admin.lab_admin? && space_type == "Lab"
    errors.add(:admin, 'expected to be lab admin, not admin') if admin.admin? && space_type == "LabSpace"
  end
end
