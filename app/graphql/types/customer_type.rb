Types::CustomerType = GraphQL::ObjectType.define do
  interfaces [Interfaces::Model]

  name 'Customer'
  description 'customer of a table'

  field :name, !types.String
  field :table, Types::TableType
  field :items, types[Types::ItemType], resolve ->() do
    123
  end
end
