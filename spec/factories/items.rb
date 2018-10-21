FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    preferences { Faker::Lorem.words }
    customer { build(:customer) }
    status 0
  end
end
