require 'rails_helper'

RSpec.describe EquipmentCapability, type: :model do
  subject {
    FactoryBot.build(:equipment_capability)
  }

  describe 'validations' do
    it { should belong_to(:capability) }
    it { should belong_to(:equipment) }

    it { should validate_presence_of(:capability) }
    it { should validate_presence_of(:equipment) }
    it { should validate_uniqueness_of(:capability_id).scoped_to(:equipment_id) }
  end
end
