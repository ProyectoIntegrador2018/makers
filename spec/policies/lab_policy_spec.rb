require 'rails_helper'

RSpec.describe LabPolicy, type: :policy do
  subject { described_class.new(user, lab) }

  let(:lab) { create :lab }

  context 'for a visitor' do
    let(:user) { nil }
    it { should permit_actions([:index, :show]) }
    it { should forbid_actions([:new, :create, :edit, :update, :destroy]) }
  end

  context 'for a regular user' do
    let(:user) { create :user }
    it { should permit_actions([:index, :show]) }
    it { should forbid_actions([:new, :create, :edit, :update, :destroy]) }
  end

  context 'for a superadmin' do
    let(:user) { create :user, role: :superadmin }
    it { should permit_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for an admin of that lab' do
    let(:user) do
      admin = create :user, role: :admin
      lab.admins << admin
      admin
    end

    it { should permit_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for a lab admin' do
    let(:user) do
      lab_admin = create(:user, role: :lab_admin)
      lab_space = create(:lab_space, lab: lab)
      lab_space.admins << lab_admin
      lab_admin
    end

    it { should permit_actions([:index, :show]) }
    it { should forbid_actions([:new, :create, :edit, :update, :destroy]) }
  end

  context 'for an admin of another lab' do
    let(:user) { create(:user, role: :admin) }
    let(:new_lab) do
      new_lab = create(:lab)
      new_lab.admins << user
      new_lab
    end

    # :new, :create omitted
    it { should permit_actions([:show, :index]) }
    it { should forbid_actions([:edit, :update, :destroy]) }
  end
end
