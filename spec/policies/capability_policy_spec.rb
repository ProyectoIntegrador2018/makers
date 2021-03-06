require 'rails_helper'

RSpec.describe CapabilityPolicy, type: :policy do
  subject { described_class.new(user, capability) }

  let(:capability) { Capability.new(name: "name") }

  context 'for regular user' do
    let(:user) { create(:user) }

    it { should permit_actions([:index, :show]) }
    it { should forbid_actions([:new, :create, :edit, :update, :destroy]) }
  end

  context 'for a superadmin' do
    let(:user) { create(:user, role: :superadmin) }

    it { should permit_actions([:index, :show, :new, :create]) }
    it { should forbid_actions([:edit, :update, :destroy]) }
  end

  context 'for a lab space admin of that equipment' do
    let(:user) { create(:user, role: :lab_space_admin) }

    it { should permit_actions([:index, :show, :new, :create]) }
    it { should forbid_actions([:edit, :update, :destroy]) }
  end

  context 'for a lab admin of that equipment' do
    let(:user) { create(:user, role: :lab_admin) }

    it { should permit_actions([:index, :show, :new, :create]) }
    it { should forbid_actions([:edit, :update, :destroy]) }
  end
end
