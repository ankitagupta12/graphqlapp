Types::TableType = GraphQL::ObjectType.define do
  interfaces [Interfaces::Model]

  name 'Table'
  description 'a table in the restaurant'

  field :name, !types.String
  field :capacity, !types.Int
  field :customers, types[Types::CustomerType]
end
