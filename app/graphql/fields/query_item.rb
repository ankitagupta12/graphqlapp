# Item query
Fields::QueryItem = GraphQL::Field.define do
  description "an item"
  type(Types::ItemType)

  argument :id, types.ID

  resolve ->(obj, args, ctx){
    Item.find(args[:id])
  }
end
