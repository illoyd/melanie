##
# Organization class!
class Organization
  include ArangoDB::OGM::Vertex
  include ArangoDB::OGM::Document::Timestamps

  include HasNotes
  include HasMentions

  # Name, kind, default, validates
  attribute :name, :string
end