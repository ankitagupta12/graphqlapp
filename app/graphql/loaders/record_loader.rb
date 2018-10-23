module Loaders
  class RecordLoader < GraphQL::Batch::Loader
    def initialize(model, column, where)
      @model = model
      @column = column
      @where = where
    end

    def perform(keys)
      records = @model.where(@where).where(@column => keys)
      records.each do |record|
        fulfill(record.public_send(@column), record)
      end
      keys.each do |key|
        fulfill(key, nil) unless fulfilled?(key)
      end
    end
  end
end