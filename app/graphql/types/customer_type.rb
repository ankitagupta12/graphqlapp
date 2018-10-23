Types::CustomerType = GraphQL::ObjectType.define do
  interfaces [Interfaces::Model]

  name 'Customer'
  description 'customer of a table'

  field :name, !types.String
  field :table, Types::TableType

  field :items, types[Types::ItemType]
end









# =====1====== field with base resolver
# field :items, types[Types::ItemType] do
#   resolve ->(obj, _args, _ctx) do
#     Loaders::OneToManyLoader.for(Item, :customer_id).load(obj.id)
#   end
# end



# =====2====== field with where param
# field :items, types[Types::ItemType] do
#   argument :status, types.String
#
#   resolve ->(obj, args, _ctx) do
#     Loaders::OneToManyLoader.for(
#         Item,
#         :customer_id,
#         where: args.to_h
#     ).load(obj.id)
#   end
# end


# =====3====== with query
# field :items, types[Types::ItemType] do
#   argument :name_search, types.String
#
#   resolve ->(obj, args, _ctx) do
#     query = Item.where("items.name LIKE '%#{args[:name_search]}%'")
#
#     Loaders::OneToManyLoader.for(
#         :customer_id, query
#     ).load(obj.id)
#   end
# end

# ========4==== query factory
# field :items, types[Types::ItemType] do
#   argument :name_search, types.String
#
#   resolve ->(obj, args, _ctx) do
#     query = QueryFactory.get_query(args[:name_search])
#
#     Loaders::OneToManyLoader.for(
#         :customer_id, query
#     ).load(obj.id)
#   end
# end
#
# class QueryFactory
#   def self.get_query(name_search)
#     @queries ||= {}
#     @queries[name_search] ||= Item.where("items.name LIKE '%#{name_search}%'")
#   end
# end

# ====5===== loader key
# field :items, types[Types::ItemType] do
#   argument :name_search, types.String
#
#   resolve ->(obj, args, _ctx) do
#     query = Item.where("items.name LIKE '%#{args[:name_search]}%'")
#
#     Loaders::OneToManyLoader.for(
#         :customer_id, query, 'Types::CustomerType::items'
#     ).load(obj.id)
#   end
# end