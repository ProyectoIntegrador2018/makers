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

  # Aids in building queries for management
  has_many :managed_labs, through: :lab_administrations, source: :space, source_type: 'Lab'
  has_many :directly_managed_lab_spaces, through: :lab_administrations, source: :space, source_type: 'LabSpace'
  has_many :indirectly_managed_lab_spaces, through: :managed_labs, source: :lab_spaces
  has_many :directly_managed_equipment, through: :directly_managed_lab_spaces, source: :equipment
  has_many :indirectly_managed_equipment, through: :indirectly_managed_lab_spaces, source: :equipment
  has_many :directly_managed_reservations, through: :indirectly_managed_equipment, source: :reservations
  has_many :indirectly_managed_reservations, through: :directly_managed_equipment, source: :reservations

  def managed_lab_spaces
    LabSpace.find_by_sql("(#{directly_managed_lab_spaces.to_sql}) UNION (#{indirectly_managed_lab_spaces.to_sql})")
  end

  def managed_equipment
    LabSpace.find_by_sql("(#{directly_managed_equipment.to_sql}) UNION (#{indirectly_managed_equipment.to_sql})")
  end

  def managed_reservations
    LabSpace.find_by_sql("(#{directly_managed_reservations.to_sql}) UNION (#{indirectly_managed_reservations.to_sql})")
  end

  def manages?(managed)
    case managed
    when Lab
      manages_lab?(managed)
    when LabSpace
      manages_lab_space?(managed)
    when Reservation
      manages_reservation?(managed)
    else
      false
    end
  end

  private

  def manages_lab?(lab)
    managed_labs.where(id: lab.id).exists?
  end

  def manages_lab_space?(lab_space)
    directly_managed_lab_spaces.where(id: lab_space.id).exists? || indirectly_managed_lab_spaces.where(id: lab_space.id).exists?
  end

  def manages_reservation?(reservation)
    directly_managed_reservations.where(id: reservation.id).exists? || indirectly_managed_reservations.where(id: reservation.id).exists?
  end
end
