require 'rails_helper'

RSpec.describe EquipmentMaterial, type: :model do
  subject {
    FactoryBot.build(:equipment_material)
  }

  describe 'validations' do
    it { should belong_to(:material) }
    it { should belong_to(:equipment) }

    it { should validate_presence_of(:material) }
    it { should validate_presence_of(:equipment) }
    it { should validate_uniqueness_of(:material_id).scoped_to(:equipment_id) }
  end
end
