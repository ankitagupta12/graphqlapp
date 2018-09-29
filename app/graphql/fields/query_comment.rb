# Comment query
Fields::QueryComment = GraphQL::Field.define do
  description "an article"
  type(Types::ArticleType)

  argument :id, !types.Int

  resolve ->(obj, args, ctx){
    Comment.find(args[:id])
  }
end
