module Loaders
  class OneToManyLoader < GraphQL::Batch::Loader
    def initialize(model, column)
      @model = model
      @column = column
    end

    def perform(keys)
      # query
      records = @model.where(@column => keys).group_by(&@column)

      # fulfill
      keys.each do |key|
        fulfill(key, records[key] || [])
      end
    end
  end
end










# =====1======base loader
# class OneToManyLoader < GraphQL::Batch::Loader
#   def initialize(model, column)
#     @model = model
#     @column = column
#   end
#
#   def perform(keys)
#     # query
#     records = @model.where(@column => keys).group_by(&@column)
#
#     # fulfill
#     keys.each do |key|
#       fulfill(key, records[key] || [])
#     end
#   end
# end



# =====2====== simple filter
# class OneToManyLoader < GraphQL::Batch::Loader
#   def initialize(model, column, where: nil)
#     @model = model
#     @column = column
#     @where = where
#   end
#
#   def perform(keys)
#     # query
#     records = @model.where(@where).
#                 where(@column => keys).
#                 group_by(&@column)
#
#     # fulfill
#     keys.each do |key|
#       fulfill(key, records[key] || [])
#     end
#   end
# end

# =====3===== with query
# class OneToManyLoader < GraphQL::Batch::Loader
#   def initialize(column, query)
#     @column = column
#     @query = query
#   end
#
#   def perform(keys)
#     # query
#     records = @query.where(@column => keys).group_by(&@column)
#
#     # fulfill
#     keys.each do |key|
#       fulfill(key, records[key] || [])
#     end
#   end
# end

# =========5===== loader key
# class OneToManyLoader < GraphQL::Batch::Loader
#   def initialize(column, query, _loader_key)
#     @column = column
#     @query = query
#   end
#
#   def perform(keys)
#     # query
#     records = @query.where(@column => keys).group_by(&@column)
#
#     # fulfill
#     keys.each do |key|
#       fulfill(key, records[key] || [])
#     end
#   end
#
#   def self.loader_key_for(*group_args)
#     [self].concat(group_args.last)
#   end
# end




