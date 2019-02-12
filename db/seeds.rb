# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Event.destroy_all
Attendance.destroy_all

10.times do
	User.create(email: "#{Faker::Name.first_name.downcase}@yopmail.com", password: "aaaaaa", password_confirmation: "aaaaaa", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Hipster.sentence)
end

5.times do
	Event.create(start_date: Faker::Date.forward(365), duration: 45, title: Faker::Hipster.sentence, description: Faker::Hipster.paragraph, price: rand(1..1000), location: Faker::Address.city, admin: User.all.sample)
end

20.times do
	Attendance.create(stripe_customer_id: Faker::Code.nric, participant: User.all.sample, event: Event.all.sample)
end