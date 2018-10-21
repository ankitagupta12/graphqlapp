Enums::ItemStatus = GraphQL::EnumType.define do
  name 'ItemStatusEnum'
  Item.statuses.each_key do |key|
    value(key)
  end
end
