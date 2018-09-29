Types::ArticleType = GraphQL::ObjectType.define do
  interfaces [Interfaces::Model]

  name 'Article'
  description 'an article from the blog'

  field :title, !types.String
  field :text, !types.String
  field :comments, types[Types::CommentType]
end
