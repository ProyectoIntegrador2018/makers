require 'rails_helper'

RSpec.describe Equipment, type: :model do
  subject {
    FactoryBot.build(:equipment)
  }

  describe 'validations' do
    it { should have_many(:equipment_materials) }
    it { should have_many(:materials).through(:equipment_materials) }
    it { should have_many(:equipment_capabilities) }
    it { should have_many(:capabilities).through(:equipment_capabilities) }
    it { should have_many(:available_hours) }
    it { should have_many(:reservations) }

    it { should belong_to(:lab_space) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:lab_space) }
    it { should validate_presence_of(:max_usage) }
    it { should validate_presence_of(:rest_time) }
  end
end
