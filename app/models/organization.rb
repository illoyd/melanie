##
# Organization class!
class Organization
  include ArangoDB::OGM::Vertex
  include ArangoDB::OGM::Model::Timestamps

  include HasNotes
  include HasMentions
  include HasWikipedia

  # Name, kind, default, validates
  attribute :name, :string
end