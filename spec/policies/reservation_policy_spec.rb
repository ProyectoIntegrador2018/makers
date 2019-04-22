require 'rails_helper'

RSpec.describe ReservationPolicy do
  subject { described_class.new(user, reservation) }

  let(:lab) { create :lab }
  let(:lab_space) { create :lab_space, lab: lab }
  let(:equipment) { create :equipment, lab_space: ls }
  let(:reservation) { build(:reservation, user: user, equipment: equipment) }

  context 'for a visitor' do
    let(:user) { nil }

    it { should forbid_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for regular user owning that reservation' do
    let(:user) { create(:user) }

    it { should permit_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for another user not owning the reservation' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    it { should forbid_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for a superadmin' do
    let(:user) { create(:user) }
    let(:admin) { create(:user, role: :superadmin) }

    it { should permit_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for an admin of that lab' do
    let(:user) { create(:user) }
    let(:admin) { create(:user, role: :admin) }

    admin.managed_labs << lab
    it { should permit_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for a lab admin of that lab space' do
    let(:user) { create(:user) }
    let(:lab_admin) { create(:user, role: :lab_admin) }

    lab_space.admins << lab_admin
    it { should permit_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for an admin of another lab' do
    let(:user) { create(:user) }
    let(:admin) { create(:user, role: :admin) }
    let(:new_lab) { create(:lab) }

    admin.managed_labs << new_lab
    it { should permit_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for a lab admin of another lab space' do
    let(:user) { create(:user) }
    let(:lab_admin) { create(:user, role: :lab_admin) }
    let(:new_lab_space) { create :lab_space, lab: lab }

    new_lab_space.admins << lab_admin
    it { should permit_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end
end
