Types::CommentType = GraphQL::ObjectType.define do
  name 'Comment'
  description 'comment for an article'

  field :id, !types.Int
  field :body, !types.String
  field :createdAt, !types.String, property: :created_at
  field :updatedAt, !types.String, property: :updated_at
end
