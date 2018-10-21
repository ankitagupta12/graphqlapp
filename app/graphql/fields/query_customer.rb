# Customer query
Fields::QueryCustomer = GraphQL::Field.define do
  description "a customer"
  type(Types::CustomerType)

  argument :id, types.ID

  resolve ->(obj, args, ctx){
    Customer.find(args[:id])
  }
end
