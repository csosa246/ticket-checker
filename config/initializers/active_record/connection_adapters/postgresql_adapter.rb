require 'active_record/connection_adapters/postgresql_adapter'

# ActiveRecord does not, by default, know about the geometry type.  Here we
# register it as a string type; the database will do the right thing, and
# AR will simply treat it as a string.
#
# Without this addition to the PostgreSQL adapeter we receive this error:
#
#   unknown OID 69543: failed to recognize type of 'boundaries'. It will be treated as String.
#
# In this case `boundaries` is the name of a column on the `zones` table that
# is type `geometry`.
class ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
  prepend(Module.new do
    def initialize_type_map(map = type_map)
      super
      map.register_type('geometry', OID::SpecializedString.new(:geometry))
    end
  end)
end

