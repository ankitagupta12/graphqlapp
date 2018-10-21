describe Fields::QueryCustomer do
  Given do
    schema = GraphQL::Client.load_schema(GraphqlappSchema)
    @graphql_client = GraphQL::Client.new(schema: schema, execute: GraphqlappSchema)
    TableFragment = @graphql_client.parse(
      file_fixture('/graphql/fragments/table_fragment.graphql').read
    )
    CustomerFragment = @graphql_client.parse(
      file_fixture('/graphql/fragments/customer_fragment.graphql').read
    )
    CustomerQueryFragment = @graphql_client.parse(
      file_fixture('/graphql/query_fragments/customer_query_fragment.graphql').read
    )
    query_file = 'graphql/queries/full_schema_customers_query.graphql'
    Query = @graphql_client.parse(file_fixture(query_file).read)
  end

  Given(:customer) { create(:customer) }

  context 'get versions without filters' do
    When(:result) do
      @graphql_client.query(
        Query,
        variables: { id: customer.id }
      )
    end
    Then do
      result.data.customer.to_h['id'] == customer.id.to_s
    end
  end
end
