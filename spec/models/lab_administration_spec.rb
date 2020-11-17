require 'rails_helper'

RSpec.describe LabAdministration, type: :model do
  subject {
    FactoryBot.build(:lab_administration)
  }

  describe 'validations' do
    it { should belong_to(:admin) }
    it { should belong_to(:space) }
  end
end
