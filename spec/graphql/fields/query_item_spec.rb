describe Fields::QueryItem do
  Given do
    schema = GraphQL::Client.load_schema(GraphqlappSchema)
    @graphql_client = GraphQL::Client.new(schema: schema, execute: GraphqlappSchema)
    ItemFragment = @graphql_client.parse(
      file_fixture('/graphql/fragments/item_fragment.graphql').read
    )
    ItemQueryFragment = @graphql_client.parse(
      file_fixture('/graphql/query_fragments/item_query_fragment.graphql').read
    )
    query_file = 'graphql/queries/full_schema_items_query.graphql'
    Query = @graphql_client.parse(file_fixture(query_file).read)
  end

  Given(:item) { create(:item) }

  context 'get versions without filters' do
    When(:result) do
      @graphql_client.query(
        Query,
        variables: { id: item.id }
      )
    end
    Then do
      result.data.item.to_h['id'] == item.id.to_s
    end
  end
end
