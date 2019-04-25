require 'rails_helper'

RSpec.describe DashboardPolicy, type: :policy do
  subject { described_class.new(user, :dashboard) }

  context 'for regular user' do
    let(:user) { create(:user) }

    it {
      should forbid_actions [:users, :available_hours, :capabilities, :equipment,
                             :equipment_capabilities, :equipment_materials, :labs,
                             :lab_spaces, :materials, :reservations, :lab_administrations]
    }
  end

  context 'for a superadmin' do
    let(:user) { create(:user, role: :superadmin) }

    it { should forbid_actions [:equipment_capabilities, :equipment_materials] }

    it {
      should permit_actions [:users, :available_hours, :capabilities, :equipment,
                             :labs, :lab_spaces, :materials, :reservations, :lab_administrations]
    }
  end

  context 'for an admin' do
    let(:user) { create(:user, role: :admin) }

    it { should forbid_actions [:equipment_capabilities, :equipment_materials] }

    it {
      should permit_actions [:users, :available_hours, :capabilities, :equipment,
                             :labs, :lab_spaces, :materials, :reservations, :lab_administrations]
    }
  end

  context 'for a lab admin' do
    let(:user) { create(:user, role: :lab_admin) }

    it { should forbid_actions [:equipment_capabilities, :equipment_materials] }

    it { should forbid_actions [:labs, :lab_administrations] }

    it {
      should permit_actions [:users, :available_hours, :capabilities, :equipment,
                             :lab_spaces, :materials, :reservations]
    }
  end

  context 'for a lab admin that manages a lab' do
    let(:user) do
      lab_admin = create(:user, role: :lab_admin)
      lab = create(:lab)
      lab.admins << lab_admin
      lab_admin
    end

    it { should forbid_actions [:equipment_capabilities, :equipment_materials] }

    it { should forbid_actions [:lab_administrations] }

    it {
      should permit_actions [:users, :available_hours, :capabilities, :equipment,
                             :labs, :lab_spaces, :materials, :reservations]
    }
  end
end
