require 'rails_helper'

RSpec.describe Lab, type: :model do
  subject {
    FactoryBot.build(:lab)
  }

  describe 'validations' do
    it { should belong_to(:user).optional }

    it { should have_many(:lab_spaces) }
    it { should have_many(:lab_administrations) }
    it { should have_many(:admins).through(:lab_administrations) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:location_link) }
  end
end
