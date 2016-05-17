##
# Note class!
class Note
  include ArangoDB::OGM::Vertex
  include ArangoDB::OGM::Model::Timestamps

  include HasAuthors
  include HasMentions

  # Name, kind, default, validations
  attribute :body, :string, validates: { presence: true }

  def describes
    neighbours(Describe)
  end

end