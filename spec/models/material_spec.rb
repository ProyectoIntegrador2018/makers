require 'rails_helper'

RSpec.describe Material, type: :model do
  subject {
    FactoryBot.build(:material)
  }

  describe 'validations' do
    it { should have_many(:equipment_materials) }
    it { should have_many(:equipment).through(:equipment_materials) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
