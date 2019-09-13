class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # default is 0 (:user)
  enum role: [:user, :superadmin, :lab_space_admin, :lab_admin]

  validates :given_name, :institutional_id, presence: true

  has_many :reservations
  has_many :labs
  has_many :lab_spaces

  # Aids in building queries for administration
  has_many :lab_administrations, foreign_key: 'admin_id'

  # All associations stemming from association with labs through lab_administrations, should be used for role: admin
  has_many :directly_managed_labs, through: :lab_administrations, source: :space, source_type: 'Lab'
  has_many :indirectly_managed_lab_spaces, through: :directly_managed_labs, source: :lab_spaces
  has_many :indirectly_managed_equipment, through: :indirectly_managed_lab_spaces, source: :equipment
  has_many :indirectly_managed_reservations, through: :indirectly_managed_equipment, source: :reservations
  has_many :lab_lab_administrations, through: :directly_managed_labs, source: :lab_administrations
  has_many :indirectly_managed_lab_administrations, through: :indirectly_managed_lab_spaces, source: :lab_administrations

  # All associations stemming from association with lab spaces through lab_administrations, should be used for role: lab_admin
  has_many :directly_managed_lab_spaces, through: :lab_administrations, source: :space, source_type: 'LabSpace'
  has_many :directly_managed_equipment, through: :directly_managed_lab_spaces, source: :equipment
  has_many :directly_managed_reservations, through: :directly_managed_equipment, source: :reservations
  has_many :directly_managed_lab_administrations, through: :directly_managed_lab_spaces, source: :lab_administrations

  def managed_labs
    return Lab.all if role == 'superadmin'

    directly_managed_labs
  end

  def managed_lab_spaces
    return LabSpace.all if role == 'superadmin'

    lab_spaces = LabSpace.find_by_sql("(#{directly_managed_lab_spaces.to_sql}) UNION (#{indirectly_managed_lab_spaces.to_sql})")
    LabSpace.where(id: lab_spaces.map(&:id))
  end

  def managed_equipment
    return Equipment.all if role == 'superadmin'

    equipment = Equipment.find_by_sql("(#{directly_managed_equipment.to_sql}) UNION (#{indirectly_managed_equipment.to_sql})")
    Equipment.where(id: equipment.map(&:id))
  end

  def managed_reservations
    return Reservation.all if role == 'superadmin'

    reservations = Reservation.find_by_sql("(#{directly_managed_reservations.to_sql}) UNION (#{indirectly_managed_reservations.to_sql})")
    Reservation.where(id: reservations.map(&:id))
  end

  def managed_lab_administrations
    return LabAdministration.all if role == 'superadmin'

    lab_administrations = LabAdministration.find_by_sql("(#{lab_lab_administrations.to_sql}) UNION (#{indirectly_managed_lab_administrations.to_sql}) UNION (#{directly_managed_lab_administrations.to_sql})")
    LabAdministration.where(id: lab_administrations.map(&:id))
  end

  def manages?(managed)
    case managed
    when Lab
      manages_lab?(managed)
    when LabSpace
      manages_lab_space?(managed)
    when Equipment
      manages_equipment?(managed)
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
    lab_space_id = lab_space.id
    directly_managed_lab_spaces.where(id: lab_space_id).exists? || indirectly_managed_lab_spaces.where(id: lab_space_id).exists?
  end

  def manages_equipment?(equipment)
    manages_lab_space?(equipment.lab_space)
  end

  def manages_reservation?(reservation)
    reservation_id = reservation.id
    directly_managed_reservations.where(id: reservation_id).exists? || indirectly_managed_reservations.where(id: reservation_id).exists?
  end
end
