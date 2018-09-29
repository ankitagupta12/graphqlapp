Types::CommentType = GraphQL::ObjectType.define do
  interfaces [Interfaces::Model]

  name 'Comment'
  description 'comment for an article'

  field :body, !types.String
end
