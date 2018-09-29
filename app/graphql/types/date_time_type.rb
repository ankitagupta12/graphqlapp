Types::DateTimeType = GraphQL::ScalarType.define do
  name 'DateTime'
  description 'The DateTime scalar type represents date time strings'

  coerce_input ->(value, _ctx) { Time.zone.parse(value) }
  coerce_result ->(value, _ctx) { value.strftime('%Y-%m-%dT%H:%M:%S.%L%:z') }
end
