require 'rails_helper'

RSpec.describe LabSpace, type: :model do
  subject {
    FactoryBot.build(:lab_space)
  }

  describe 'validations' do
    it { should belong_to(:lab) }
    it { should belong_to(:user).optional }

    it { should have_many(:equipment) }
    it { should have_many(:lab_administrations) }
    it { should have_many(:admins).through(:lab_administrations) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:lab) }
  end
end
