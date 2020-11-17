require 'rails_helper'

RSpec.describe AvailableHour, type: :model do
  subject {
    FactoryBot.build(:available_hour)
  }

  describe 'validations' do
    it { should belong_to(:equipment) }

    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:day_of_week) }

    it 'validates date range' do
      subject.start_time = ''
      expect(subject).to be_invalid
    end
  end
end
