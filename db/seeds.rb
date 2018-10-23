# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tables = 3.times.map do |index|
  Table.create!(name: "TABLE_#{index}")
end

customers = tables.map do |table|
  3.times.map do
    Customer.create!(
        name: Faker::Name.name,
        table: table
    )
  end
end.flatten

customers.each do |customer|
  2.times.each do
    Item.create!(
            customer: customer,
            name: Faker::Food.dish,
            status: rand(3)
    )
  end
end