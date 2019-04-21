class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # default is 0 (:user)
  enum role: [:user, :superadmin, :admin, :lab_admin]
  validates :given_name, :institutional_id, presence: true

  has_many :reservations

  has_many :lab_administrations, foreign_key: 'admin_id'
  has_many :managed_labs, through: :lab_administrations, source: :space, source_type: 'Lab'
  has_many :managed_lab_spaces, through: :lab_administrations, source: :space, source_type: 'LabSpace'
end
