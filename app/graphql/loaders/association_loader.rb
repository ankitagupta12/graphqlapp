class AssociationLoader < GraphQL::Batch::Loader
  def initialize(model, association_name)
    @model = model
    @association_name = association_name
  end

  def perform(records)
    preload_association(records)
    records.each { |record| fulfill(record, read_association(record)) }
  end

  private

  def preload_association(records)
    ::ActiveRecord::Associations::Preloader.new.preload(records, @association_name)
  end

  def read_association(record)
    record.public_send(@association_name)
  end
end
