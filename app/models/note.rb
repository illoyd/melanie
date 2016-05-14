require 'orientdb/orm'

##
# Note class!
class Note < Orientdb::ORM::V
  include Orientdb::ORM::HasTimestamps
  include Orientdb::ORM::HasEdges

  include HasAuthors

  # Name, kind, default, validations
  attribute :body, :string, validates: { presence: true }

  def describes
    out_objects(:describes)
  end

end