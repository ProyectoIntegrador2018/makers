# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

2.times do
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

  6.times do
    eq = ls.equipment.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(100, true, 10),
      image: Faker::LoremPixel.image("300x260"),
      technical_description: Faker::Lorem.sentence(300, true, 15)
    )
    5.times do |i|
      eq.available_hours.create(
        day_of_week: (i+1),
        start_time: "08:30",
        end_time: "17:30"
      )
    end
  end
end
