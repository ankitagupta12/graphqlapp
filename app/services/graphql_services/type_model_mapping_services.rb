# Service to convert Active Record Model to GraphQL Type
class GraphqlServices::TypeModelMappingService < BaseService
  MODEL_TYPE_MAPPING = {
    Article: Types::ArticleType,
    Comment: Types::CommentType
  }.freeze

  def perform(model_class)
    MODEL_TYPE_MAPPING[model_class.to_s.to_sym]
  end
end
