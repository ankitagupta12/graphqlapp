# Article query
Fields::QueryArticle = GraphQL::Field.define do
  description "an article"
  type(Types::ArticleType)

  argument :id, !types.Int

  resolve ->(obj, args, ctx){
    Article.find(args[:id])
  }
end
