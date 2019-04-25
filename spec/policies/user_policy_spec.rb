require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class.new(user, accessed_user) }

  let(:accessed_user) { create(:user) }

  context 'for a visitor' do
    let(:user) { nil }
    it { should forbid_actions([:index, :show, :edit, :update, :destroy]) }
    it { should permit_actions([:new, :create]) }
  end

  context 'for regular user' do
    let(:user) { accessed_user }
    it { should forbid_actions([:index, :new, :create]) }
    it { should permit_actions([:show, :edit, :update, :destroy]) }
  end

  context 'for another user' do
    let(:user) { create(:user) }
    it { should forbid_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for a superadmin' do
    let(:user) { create(:user, role: :superadmin) }
    it { should forbid_actions([:new, :create]) }
    it { should permit_actions([:index, :show, :edit, :update, :destroy]) }
  end

  context 'for an admin' do
    let(:user) { create(:user, role: :admin) }
    it { should forbid_actions([:new, :create, :destroy]) }
    it { should permit_actions([:index, :show, :edit, :update]) }
  end

  context 'for a lab admin' do
    let(:user) { create(:user, role: :lab_admin) }
    it { should forbid_actions([:new, :create,:edit, :update, :destroy]) }
    it { should permit_actions([:index, :show]) }
  end
end
