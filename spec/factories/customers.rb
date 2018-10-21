FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    table { build(:table) }
  end
end
