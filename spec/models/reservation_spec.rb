require 'rails_helper'
require 'faker'

RSpec.describe Reservation, type: :model do
  let(:user) {create :user}

  it "has none to begin with" do
    expect(Reservation.count).to eq 0
  end

  it "accepts reservations inside an available block" do
    lab = Lab.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(30, true, 10),
      location: "CIAP 628-F",
      image: Faker::LoremPixel.image("300x260")
    )
    ls = lab.lab_spaces.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(30, true, 10),
      hours: "Lunes a Viernes: 8 AM - 5:30 PM",
      location: "Innovaction Gym",
      contact_email: "azael.capetillo@tec.mx",
      contact_phone: Faker::PhoneNumber.cell_phone,
      image: Faker::LoremPixel.image("300x260")
    )
    eq = ls.equipment.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(100, true, 10),
      image: Faker::LoremPixel.image("300x260"),
      technical_description: Faker::Lorem.sentence(300, true, 15)
    )
    eq.available_hours.create(
      day_of_week: (1),
      start_time: "08:30",
      end_time: "17:30"
    )
    res = build(:reservation,
      start_time: Time.parse("2019-10-07T14:30:00.000Z"), #Monday, 14:30
      end_time: Time.parse("2019-10-07T16:30:00.000Z"), #Monday, 16:30
      equipment: Equipment.first,
      user: user
    )

    expect(res.valid?).to eq true
  end

  it "accepts reservations that cover two consecutive available blocks" do
    lab = Lab.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(30, true, 10),
      location: "CIAP 628-F",
      image: Faker::LoremPixel.image("300x260")
    )
    ls = lab.lab_spaces.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(30, true, 10),
      hours: "Lunes a Viernes: 8 AM - 5:30 PM",
      location: "Innovaction Gym",
      contact_email: "azael.capetillo@tec.mx",
      contact_phone: Faker::PhoneNumber.cell_phone,
      image: Faker::LoremPixel.image("300x260")
    )
    eq = ls.equipment.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(100, true, 10),
      image: Faker::LoremPixel.image("300x260"),
      technical_description: Faker::Lorem.sentence(300, true, 15)
    )
    eq.available_hours.create(
      day_of_week: (1),
      start_time: "08:30",
      end_time: "17:30"
    )
    eq.available_hours.create(
      day_of_week: (1),
      start_time: "17:30",
      end_time: "20:30"
    )
    res = build(:reservation,
      start_time: Time.parse("2019-10-07T14:30:00.000Z"), #Monday, 14:30
      end_time: Time.parse("2019-10-07T20:00:00.000Z"), #Monday, 20:00
      equipment: Equipment.first,
      user: user
    )

    expect(res.valid?).to eq true
  end

  it "accepts reservations that cover two consecutive available blocks overnight" do
    lab = Lab.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(30, true, 10),
      location: "CIAP 628-F",
      image: Faker::LoremPixel.image("300x260")
    )
    ls = lab.lab_spaces.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(30, true, 10),
      hours: "Lunes a Viernes: 8 AM - 5:30 PM",
      location: "Innovaction Gym",
      contact_email: "azael.capetillo@tec.mx",
      contact_phone: Faker::PhoneNumber.cell_phone,
      image: Faker::LoremPixel.image("300x260")
    )
    eq = ls.equipment.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(100, true, 10),
      image: Faker::LoremPixel.image("300x260"),
      technical_description: Faker::Lorem.sentence(300, true, 15)
    )
    eq.available_hours.create(
      day_of_week: (1),
      start_time: "20:30",
      end_time: "23:59"
    )
    eq.available_hours.create(
      day_of_week: (2),
      start_time: "00:00",
      end_time: "7:30"
    )

    res = build(:reservation,
      start_time: Time.parse("2019-10-07T22:30:00.000Z"), #Monday, 22:30
      end_time: Time.parse("2019-10-08T1:00:00.000Z"), #Tuesday, 1:00
      equipment: Equipment.first,
      user: user)

    expect(res.valid?).to eq true
  end

  it "does not accept reservations that cover two non consecutive avail blocks" do
    lab = Lab.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(30, true, 10),
      location: "CIAP 628-F",
      image: Faker::LoremPixel.image("300x260")
    )
    ls = lab.lab_spaces.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(30, true, 10),
      hours: "Lunes a Viernes: 8 AM - 5:30 PM",
      location: "Innovaction Gym",
      contact_email: "azael.capetillo@tec.mx",
      contact_phone: Faker::PhoneNumber.cell_phone,
      image: Faker::LoremPixel.image("300x260")
    )
    eq = ls.equipment.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(100, true, 10),
      image: Faker::LoremPixel.image("300x260"),
      technical_description: Faker::Lorem.sentence(300, true, 15)
    )
    eq.available_hours.create(
      day_of_week: (1),
      start_time: "10:30",
      end_time: "11:00"
    )
    eq.available_hours.create(
      day_of_week: (1),
      start_time: "11:01",
      end_time: "15:30"
    )

    res = build(:reservation,
      start_time: Time.parse("2019-10-07T10:50:00.000Z"), #Monday, 10:50
      end_time: Time.parse("2019-10-07T11:30:00.000Z"), #Monday, 11:30
      equipment: Equipment.first,
      user: user)

    expect(res.valid?).to eq false
  end

  it "does not accept reservations outside avail blocks" do
    lab = Lab.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(30, true, 10),
      location: "CIAP 628-F",
      image: Faker::LoremPixel.image("300x260")
    )
    ls = lab.lab_spaces.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(30, true, 10),
      hours: "Lunes a Viernes: 8 AM - 5:30 PM",
      location: "Innovaction Gym",
      contact_email: "azael.capetillo@tec.mx",
      contact_phone: Faker::PhoneNumber.cell_phone,
      image: Faker::LoremPixel.image("300x260")
    )
    eq = ls.equipment.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(100, true, 10),
      image: Faker::LoremPixel.image("300x260"),
      technical_description: Faker::Lorem.sentence(300, true, 15)
    )
    eq.available_hours.create(
      day_of_week: (1),
      start_time: "10:30",
      end_time: "11:00"
    )

    res = build(:reservation,
      start_time: Time.parse("2019-10-07T12:50:00.000Z"), #Monday, 12:50
      end_time: Time.parse("2019-10-07T13:30:00.000Z"), #Monday, 13:30
      equipment: Equipment.first,
      user: user)

    expect(res.valid?).to eq false
  end
end
