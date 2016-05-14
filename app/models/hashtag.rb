##
# Hashtag class!
class Hashtag
#   include Orientdb::ORM::HasEdges
  include ArangoDB::OGM::Vertex

  attribute :text, :string, validates: { presence: true }

  def mentions
    self.in_objects(:mentions)
  end

end
