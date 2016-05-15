##
# Note class!
class Note
  include ArangoDB::OGM::Vertex
  include ArangoDB::OGM::Document::Timestamps

  include HasAuthors

  # Name, kind, default, validations
  attribute :body, :string, validates: { presence: true }

  def describes
    out_neighbours(Describe)
  end

  def mentions
    out_neighbours(Mention)
  end

end