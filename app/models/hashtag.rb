##
# Hashtag class!
class Hashtag
  include ArangoDB::OGM::Vertex

  attribute :text, :string, validates: { presence: true }

  def mentions
    inbound_neighbours(Mention.collection_name)
  end

end
