require 'rails_helper'

RSpec.describe ReservationPolicy, type: :policy do
  subject { described_class.new(user, reservation) }

  let(:lab) { create :lab }
  let(:lab_space) { create :lab_space, lab: lab }
  let(:equipment) do
    eqpmt = create :equipment, lab_space: lab_space
    create :available_hour, equipment: eqpmt
    eqpmt
  end
  let(:reservation) { create(:reservation, user: reservation_user, equipment: equipment) }
  let(:other_user) { create(:user) }

  context 'for a visitor' do
    let(:user) { nil }
    let(:reservation) { build(:reservation, equipment: equipment) }

    it { should forbid_actions([:show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for regular user owning that reservation' do
    let(:user) { create(:user) }
    let(:reservation_user) { user }

    it { should permit_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for another user not owning the reservation' do
    let(:user) { create(:user) }
    let(:reservation_user) { other_user }

    it { should forbid_actions([:show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for a superadmin' do
    let(:user) { create(:user, role: :superadmin) }
    let(:reservation_user) { other_user }

    it { should permit_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for a lab space admin of that lab' do
    let(:reservation_user) { other_user }
    let(:user) do
      admin = create(:user, role: :lab_space_admin)
      admin.managed_labs << lab
      admin
    end

    it { should permit_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for a lab admin of that lab space' do
    let(:reservation_user) { other_user }
    let(:user) do
      lab_admin = create(:user, role: :lab_admin)
      lab_space.admins << lab_admin
      lab_admin
    end

    it { should permit_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for a lab space admin of another lab' do
    let(:reservation_user) { other_user }
    let(:user) { create(:user, role: :lab_space_admin) }
    let(:new_lab) do
      new_lab = create(:lab)
      user.managed_labs << new_lab
      new_lab
    end

    it { should forbid_actions([:show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for a lab admin of another lab space' do
    let(:reservation_user) { other_user }
    let(:user) { create(:user, role: :lab_admin) }
    let(:new_lab_space) do
      new_lab_space = create :lab_space, lab: lab
      new_lab_space.admins << user
      new_lab_space
    end

    it { should forbid_actions([:show, :new, :create, :edit, :update, :destroy]) }
  end
end
