require 'rails_helper'

RSpec.describe EquipmentMaterialPolicy, type: :policy do
  subject { described_class.new(user, equipment_material) }

  let(:lab) { create :lab }
  let(:lab_space) { create :lab_space, lab: lab }
  let(:equipment) { create :equipment, lab_space: lab_space }
  let(:material) { Material.create(name: 'test') }
  let(:equipment_material) { EquipmentMaterial.create(equipment: equipment, material: material) }

  context 'for regular user' do
    let(:user) { create(:user) }

    it { should forbid_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end

  context 'for a superadmin' do
    let(:user) { create(:user, role: :superadmin) }

    it { should forbid_actions([:index, :show, :edit, :update]) }
    it { should permit_actions([:new, :create, :destroy]) }
  end

  context 'for an admin of that equipment' do
    let(:user) do
      admin = create :user, role: :admin
      lab.admins << admin
      admin
    end

    it { should forbid_actions([:index, :show, :edit, :update]) }
    it { should permit_actions([:new, :create, :destroy]) }
  end

  context 'for a lab admin of that equipment' do
    let(:user) do
      lab_admin = create(:user, role: :lab_admin)
      lab_space.admins << lab_admin
      lab_admin
    end

    it { should forbid_actions([:index, :show, :edit, :update]) }
    it { should permit_actions([:new, :create, :destroy]) }
  end

  context 'for an admin of another lab' do
    let(:user) { create(:user, role: :admin) }
    let(:new_lab) do
      new_lab = create(:lab)
      new_lab.admins << user
      new_lab
    end

    # :new omitted
    it { should forbid_actions([:index, :show, :create, :edit, :update, :destroy]) }
  end

  context 'for a lab admin of another lab space' do
    let(:user) { create(:user, role: :lab_admin) }
    let(:new_lab_space) do
      new_lab_space = create :lab_space, lab: lab
      new_lab_space.admins << user
      new_lab_space
    end

    # :new omitted
    it { should forbid_actions([:index, :show, :create, :edit, :update, :destroy]) }
  end
end
