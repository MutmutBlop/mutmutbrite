# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "*"*30
puts 'Generate a random database'
puts "*"*30
puts 'Remove the previous database'
Attendance.destroy_all
Event.destroy_all
User.destroy_all
puts "*"*30

# Users creation
20.times do |index|
  User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  description: Faker::Lorem.paragraph,
  email: "thp#{index}@yopmail.com",
  password: "password"
  )
end
puts "Users have been created"

# Events creation
20.times do
  Event.create!(
    start_date: Faker::Time.forward(420),
    duration: rand(1..100)*5,
    title: Faker::Lorem.characters(10),
    description: Faker::Lorem.paragraph,
    price: rand(1..1000),
    location: Faker::Address.city,
    user_id: User.all.sample.id
    )
end
puts "Events have been created"

70.times do
  Attendance.create!(
    event_id: Event.all.sample.id,
    user_id: User.all.sample.id
    )
end
puts "Attendances have been created"

puts '*'*30
puts 'Your database has been created'
