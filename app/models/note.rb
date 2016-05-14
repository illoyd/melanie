##
# Note class!
class Note
  include ArangoDB::OGM::Vertex
  include ArangoDB::OGM::Document::Timestamps
#   include Orientdb::ORM::HasEdges

  include HasAuthors

  # Name, kind, default, validations
  attribute :body, :string, validates: { presence: true }

  def describes
    out_objects(:describes)
  end

end