# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

require 'faker'

puts "Seeding the database..."

## Seed capabilities
12.times do
  Capability.create!(name: Faker::Verb.base)
end

## Seed materials
8.times do
  Material.create!(name: Faker::Construction.unique.material)
end

2.times do

  lab = Lab.create!(
    name: Faker::App.name,
    description: Faker::Lorem.sentence(30, true, 10),
    location: "CIAP 628-F",
    remote_image_url: "http://lorempixel.com/600/440"
  )

  ls = lab.lab_spaces.create!(
    name: Faker::App.name,
    description: Faker::Lorem.sentence(30, true, 10),
    hours: "Lunes a Viernes: 8 AM - 5:30 PM",
    location: "Innovaction Gym",
    contact_email: "azael.capetillo@tec.mx",
    contact_phone: Faker::PhoneNumber.cell_phone,
    remote_image_url: "http://lorempixel.com/600/440"
  )

  6.times do
    eq = ls.equipment.create!(
      name: Faker::App.name,
      description: Faker::Lorem.sentence(100, true, 10),
      remote_image_url: "http://lorempixel.com/600/440",
      technical_description: Faker::Lorem.sentence(40, true, 15),
      capability_ids: Capability.ids.sample(6),
      material_ids: Material.ids.sample(4)
    )
    5.times do |i|
      eq.available_hours.create!(
        day_of_week: (i+1),
        start_time: "08:30 CST",
        end_time: "17:30 CST"
      )
    end
  end
end




## Seed users
puts "\tSeeding users..."

johndoe = User.create!(
  email: "johndoe@itesm.mx",
  password: "johndoe",
  given_name: "John",
  last_name: "Doe",
  institutional_id: "A00000001"
)
johndoe.confirm

janedoe = User.create!(
  email: "janedoe@itesm.mx",
  password: "janedoe",
  given_name: "Jane",
  last_name: "Doe",
  institutional_id: "A00000002"
)
janedoe.confirm


# Super admin
admin_user = User.create!(
  email: "admin@itesm.mx",
  password: "admin123",
  role: :superadmin,
  given_name: "Admin",
  institutional_id: "A00000000"
)
admin_user.confirm

puts "Success! Inserted records into the database"
