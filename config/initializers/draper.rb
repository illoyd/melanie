require 'orientdb/orm'

# Inject decoratable into V and E
class Orientdb::ORM::V
  include Draper::Decoratable
end

class Orientdb::ORM::E
  include Draper::Decoratable
end
