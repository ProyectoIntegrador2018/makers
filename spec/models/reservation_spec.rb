require 'rails_helper'
require 'faker'

RSpec.describe Reservation, type: :model do
  let(:user) { create :user }
  let(:lab) { create :lab, user: user }
  let(:ls) { create :lab_space, lab: lab, user: user }
  let(:equipment) { create :equipment, lab_space: ls }

  it 'accepts reservations inside an available block' do
    create(:available_hour, day_of_week: 1, start_time: '08:30 CT', end_time: '17:30 CT', equipment: equipment)
    res_start = set_day_of_next_week(current_date_at(14.5), 1) # Next monday, same time
    res_end = set_day_of_next_week(current_date_at(16.5), 1) # Next monday, same time
    res = build(:reservation, 
                start_time: res_start,
                end_time: res_end,
                equipment: equipment,
                user: user)
    expect(res).to be_valid
  end

  it 'accepts reservations that cover two consecutive available blocks' do
    create(:available_hour, day_of_week: 1, start_time: '08:30 CT', end_time: '17:30 CT', equipment: equipment)
    create(:available_hour, day_of_week: 1, start_time: '17:30 CT', end_time: '20:30 CT', equipment: equipment)
    res_start = set_day_of_next_week(current_date_at(14.5), 1)
    res_end = set_day_of_next_week(current_date_at(20), 1)
    res = build(:reservation,
                start_time: res_start, # Monday, 14:30
                end_time: res_end, # Monday, 20:00
                equipment: equipment,
                user: user)
    expect(res).to be_valid
  end

  it 'does not accept reservations that cover two non consecutive available blocks' do
    create(:available_hour, day_of_week: 1, start_time: '10:30 CT', end_time: '11:00 CT', equipment: equipment)
    create(:available_hour, day_of_week: 1, start_time: '11:01 CT', end_time: '15:30 CT', equipment: equipment)

    res = build(:reservation,
                start_time: Time.parse('2019-10-07 10:50:00 CT'), # Monday, 10:50
                end_time: Time.parse('2019-10-07 11:30:00 CT'), # Monday, 11:30
                equipment: equipment,
                user: user)

    expect(res).to_not be_valid
  end

  it 'does not accept reservations outside avail blocks' do
    create(:available_hour, day_of_week: 1, start_time: '10:30 CT', end_time: '11:00 CT', equipment: equipment)

    res = build(:reservation,
                start_time: Time.parse('2019-10-07 12:50:00 CT'), # Monday, 12:50
                end_time: Time.parse('2019-10-07 13:30:00 CT'), # Monday, 13:30
                equipment: equipment,
                user: user)

    expect(res).to_not be_valid
  end
end

def current_date_at(decimal_time)
  DateTime.now.beginning_of_day + decimal_time.hours
end

def set_day_of_next_week(date, day_of_week)
  date + ((day_of_week - date.wday) % 7)
end