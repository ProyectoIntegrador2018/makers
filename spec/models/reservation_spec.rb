require 'rails_helper'
require 'faker'

# To ensure reservation is in the future, otherwise :date_range_valid fails
def future_monday
  now = Time.current + 7.day
  to_add = (1 - now.wday + 7) % 7
  now + to_add.day
end

RSpec.describe Reservation, type: :model do
  let(:user) { create :user }
  let(:lab) { create :lab }
  let(:ls) { create :lab_space, lab: lab }
  let(:equipment) { create :equipment, lab_space: ls }

  it 'has none to begin with' do
    expect(Reservation.count).to eq 0
  end

  it 'accepts reservations that cover the whole available block' do
    create(:available_hour,
           day_of_week: 1,
           start_time: '12:00 CT',
           end_time: '14:00 CT',
           equipment: equipment
    )
    res = build(:reservation,
                start_time: future_monday.at_noon,
                end_time: future_monday.at_noon + 2.hour, # Ends at 14:00
                equipment: equipment,
                user: user
    )
    expect(res.valid?).to eq true
  end

  it 'accepts reservations inside an available block' do
    create(:available_hour,
           day_of_week: 1,
           start_time: '08:30 CT',
           end_time: '17:30 CT',
           equipment: equipment
    )

    res = build(:reservation,
                start_time: future_monday.at_noon,
                end_time: future_monday.at_noon + 2.hour, # Ends at 14:00
                equipment: equipment,
                user: user
    )
    expect(res.valid?).to eq true
  end

  it 'accepts reservations that cover two consecutive available blocks' do
    create(:available_hour,
           day_of_week: 1,
           start_time: '08:30 CT',
           end_time: '17:30 CT',
           equipment: equipment
    )
    create(:available_hour,
           day_of_week: 1,
           start_time: '17:30 CT',
           end_time: '20:30 CT',
           equipment: equipment
    )

    res = build(:reservation,
                start_time: future_monday.at_noon,
                end_time: future_monday.at_noon + 8.hour, # Ends at 20:00
                equipment: equipment,
                user: user
    )

    expect(res.valid?).to eq true
  end

  it 'accepts overnight reservations that cover two consecutive available blocks' do
    create(:available_hour,
           day_of_week: 1,
           start_time: '20:30 CT',
           end_time: '23:59 CT',
           equipment: equipment
    )
    create(:available_hour,
           day_of_week: 2,
           start_time: '00:00 CT',
           end_time: '7:30 CT',
           equipment: equipment
    )

    res = build(:reservation,
                start_time: future_monday.at_noon + 10.hour, # 22:00
                end_time: future_monday.at_end_of_day + 4.hour, # Tuesday, 3:59
                equipment: equipment,
                user: user)

    expect(res.valid?).to eq true
  end

  it 'does not accept reservations that cover two non consecutive avail blocks' do
    create(:available_hour,
           day_of_week: 1,
           start_time: '10:30 CT',
           end_time: '11:00 CT',
           equipment: equipment
    )
    # 10 minute gap between blocks
    create(:available_hour,
           day_of_week: 1,
           start_time: '11:10 CT',
           end_time: '12:00 CT',
           equipment: equipment
    )

    res = build(:reservation,
                start_time: future_monday.at_noon - 1.hour - 10.minute, # 10:50
                end_time: future_monday.at_noon - 30.minute, # 11:30
                equipment: equipment,
                user: user)

    expect(res.valid?).to eq false
  end

  it 'does not accept reservations partially inside avail blocks' do
    create(:available_hour,
           day_of_week: 1,
           start_time: '10:00 CT',
           end_time: '11:30 CT',
           equipment: equipment
    )

    res = build(:reservation,
                start_time: future_monday.at_noon - 1.hour, # 11:00
                end_time: future_monday.at_noon,
                equipment: equipment,
                user: user)

    expect(res.valid?).to eq false

    res = build(:reservation,
                start_time: future_monday.at_noon - 3.hour, # 9:00
                end_time: future_monday.at_noon - 1.hour, # 11:00
                equipment: equipment,
                user: user)

    expect(res.valid?).to eq false
  end

  it 'does not accept reservations outside avail blocks' do
    create(:available_hour,
           day_of_week: 1,
           start_time: '10:30 CT',
           end_time: '11:00 CT',
           equipment: equipment
    )

    res = build(:reservation,
                start_time: future_monday.at_noon,
                end_time: future_monday.at_noon + 1.hour, # 13:00
                equipment: equipment,
                user: user)

    expect(res.valid?).to eq false
  end
end
