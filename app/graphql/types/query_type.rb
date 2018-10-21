Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  field :table, Fields::QueryTable
  field :customer, Fields::QueryCustomer
  field :item, Fields::QueryItem
end
