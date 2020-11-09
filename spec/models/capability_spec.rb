require 'rails_helper'

RSpec.describe Capability, type: :model do
  subject {
    FactoryBot.build(:capability)
  }

  describe 'validations' do
    it { should have_many(:equipment_capabilities) }
    it { should have_many(:equipment).through(:equipment_capabilities) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
