FactoryBot.define do
  factory :table do
    name { Faker::Name.name }
    capacity 10
  end
end
