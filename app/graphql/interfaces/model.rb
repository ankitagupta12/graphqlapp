Interfaces::Model = GraphQL::InterfaceType.define do
  name 'ModelInterface'

  field :id, !types.ID
  field :createdAt, !Types::DateTimeType, property: :created_at
  field :updatedAt, !Types::DateTimeType, property: :updated_at
end
