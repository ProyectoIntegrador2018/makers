class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # default is 0 (:user)
  enum role: [:user, :superadmin, :admin, :lab_admin]

  has_many :reservations
end
