Types::ItemType = GraphQL::ObjectType.define do
  interfaces [Interfaces::Model]

  name 'Item'
  description 'item ordered by customer'

  field :name, !types.String
  field :preferences, !types.String
  field :customer, Types::CustomerType
  field :status, !Enums::ItemStatus
end
