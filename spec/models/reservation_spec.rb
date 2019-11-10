require 'rails_helper'
require 'faker'

RSpec.describe Reservation, type: :model do
  let(:user) { create :user }
  let(:lab) { create :lab }
  let(:ls) { create :lab_space, lab: lab }
  let(:equipment) { create :equipment, lab_space: ls }

  it 'accepts reservations inside an available block' do
    create(:available_hour, day_of_week: 1, start_time: '08:30 CT', end_time: '17:30 CT', equipment: equipment)
    binding.pry
    res = build(:reservation,
                start_time: Time.parse('2019-10-07 14:30:00 CT'), # Monday, 14:30
                end_time: Time.parse('2019-10-07 16:30:00 CT'), # Monday, 16:30
                equipment: equipment,
                user: user
    )

    expect(res.valid?).to eq true
  end

  it 'accepts reservations that cover two consecutive available blocks' do
    create(:available_hour, day_of_week: 1, start_time: '08:30 CT', end_time: '17:30 CT', equipment: equipment)
    create(:available_hour, day_of_week: 1, start_time: '17:30 CT', end_time: '20:30 CT', equipment: equipment)

    res = build(:reservation,
                start_time: Time.parse('2019-10-07 14:30:00 CT'), # Monday, 14:30
                end_time: Time.parse('2019-10-07 20:00:00 CT'), # Monday, 20:00
                equipment: equipment,
                user: user
    )

    expect(res.valid?).to eq true
  end

  it 'accepts reservations that cover two consecutive available blocks overnight' do
    create(:available_hour, day_of_week: 1, start_time: '20:30 CT', end_time: '23:59 CT', equipment: equipment)
    create(:available_hour, day_of_week: 2, start_time: '00:00 CT', end_time: '7:30 CT', equipment: equipment)

    res = build(:reservation,
                start_time: Time.parse('2019-10-07 22:30:00 CT'), # Monday, 22:30
                end_time: Time.parse('2019-10-08 1:00:00 CT'), # Tuesday, 1:00
                equipment: equipment,
                user: user)

    expect(res.valid?).to eq true
  end

  it 'does not accept reservations that cover two non consecutive avail blocks' do
    create(:available_hour, day_of_week: 1, start_time: '10:30 CT', end_time: '11:00 CT', equipment: equipment)
    create(:available_hour, day_of_week: 1, start_time: '11:01 CT', end_time: '15:30 CT', equipment: equipment)

    res = build(:reservation,
                start_time: Time.parse('2019-10-07 10:50:00 CT'), # Monday, 10:50
                end_time: Time.parse('2019-10-07 11:30:00 CT'), # Monday, 11:30
                equipment: equipment,
                user: user)

    expect(res.valid?).to eq false
  end

  it 'does not accept reservations outside avail blocks' do
    create(:available_hour, day_of_week: 1, start_time: '10:30 CT', end_time: '11:00 CT', equipment: equipment)

    res = build(:reservation,
                start_time: Time.parse('2019-10-07 12:50:00 CT'), # Monday, 12:50
                end_time: Time.parse('2019-10-07 13:30:00 CT'), # Monday, 13:30
                equipment: equipment,
                user: user)

    expect(res.valid?).to eq false
  end
end
