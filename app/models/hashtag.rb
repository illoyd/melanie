##
# Hashtag class!
class Hashtag
  include ArangoDB::OGM::Vertex
  include HasMentions

  attribute :text, :string, validates: { presence: true }

end
