# Table query
Fields::QueryTable = GraphQL::Field.define do
  description "a table"
  type(Types::TableType)

  argument :id, types.ID

  resolve ->(obj, args, ctx){
    Table.find(args[:id])
  }
end
