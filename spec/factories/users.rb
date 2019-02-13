FactoryBot.define do
  factory :user do
  	first_name { Faker::Name.first_name }
  	last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { "aaaaaa" }
    password_confirmation { "aaaaaa" }
    description { Faker::Lorem.paragraph(25) }
  end
end