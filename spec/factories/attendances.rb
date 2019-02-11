FactoryBot.define do
  factory :attendance do
    stripe_customer_id { Faker::Code.nric }
    participant { FactoryBot.create(:user) }
    event { FactoryBot.create(:event) }
  end
end
