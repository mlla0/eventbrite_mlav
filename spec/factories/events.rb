FactoryBot.define do
  factory :event do
  	start_date { "2030-03-08 00:00:00" }
  	duration { 15 }
  	title { "Oh yeah" }
  	description { "One incredible event that you need to go to!" }
  	price { 500 }
  	location { "Paris" }
  	admin { FactoryBot.create(:user) }
  end
end
