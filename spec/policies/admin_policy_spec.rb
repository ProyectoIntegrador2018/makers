require 'rails_helper'

RSpec.describe AdminPolicy, type: :policy do
  subject { described_class.new(user, :dashboard) }

  context 'for regular user' do
    let(:user) { create(:user) }
    it { should forbid_action :show }
  end

  context 'for a superadmin' do
    let(:user) { create(:user, role: :superadmin) }
    it { should permit_action :show }
  end

  context 'for an admin' do
    let(:user) { create(:user, role: :admin) }
    it { should permit_action :show }
  end

  context 'for a lab admin' do
    let(:user) { create(:user, role: :lab_admin) }
    it { should permit_action :show }
  end
end
