require 'action_dispatch/http/request'

# Transform JSON request param keys from JSON-conventional camelCase to
# Rails-conventional snake_case:
class ActionDispatch::Request
  json_parser_without_snake_case = parameter_parsers[:json]
  parameter_parsers[:json] = ->(raw) do
    json_parser_without_snake_case.call(raw).deep_transform_keys!(&:underscore)
  end
end

