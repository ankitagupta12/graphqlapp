describe Fields::QueryTable do
  Given do
    schema = GraphQL::Client.load_schema(GraphqlappSchema)
    @graphql_client = GraphQL::Client.new(schema: schema, execute: GraphqlappSchema)
    TableFragment = @graphql_client.parse(
      file_fixture('/graphql/fragments/table_fragment.graphql').read
    )
    TableQueryFragment = @graphql_client.parse(
      file_fixture('/graphql/query_fragments/table_query_fragment.graphql').read
    )
    query_file = 'graphql/queries/full_schema_tables_query.graphql'
    Query = @graphql_client.parse(file_fixture(query_file).read)
  end

  Given(:table) { create(:table) }

  context 'get versions without filters' do
    When(:result) do
      @graphql_client.query(
        Query,
        variables: { id: table.id }
      )
    end
    Then do
      result.data.table.to_h['id'] == table.id.to_s
    end
  end
end
