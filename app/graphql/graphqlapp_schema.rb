GraphqlappSchema = GraphQL::Schema.define do
  mutation(Types::MutationType)
  query(Types::QueryType)

  resolve_type ->(_type, _record, _ctx) do
  end

  use GraphQL::Batch
end
