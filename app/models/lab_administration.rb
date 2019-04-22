class LabAdministration < ApplicationRecord
  belongs_to :admin, class_name: 'User'
  belongs_to :space, polymorphic: true

  validate :matches_role

  private

  def matches_role
    unsupported_roles
    errors.add(:admin, 'expected to be admin, not lab admin') if admin.lab_admin? && space_type == 'Lab'
    errors.add(:admin, 'expected to be lab admin, not admin') if admin.admin? && space_type == 'LabSpace'
  end

  def unsupported_roles
    errors.add(:admin, 'cannot be user') if admin.user?
    errors.add(:admin, 'cannot be superadmin, it already has all privileges') if admin.superadmin?
  end
end
