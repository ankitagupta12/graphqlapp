GraphqlappSchema = GraphQL::Schema.define do
  mutation(Types::MutationType)
  query(Types::QueryType)

  resolve_type ->(_type, record, _ctx) do
    GraphqlServices::TypeModelMappingService.new.perform(record.class)
  end
end
