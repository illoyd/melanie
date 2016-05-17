##
# Person class!
class Person
  include ArangoDB::OGM::Vertex
  include ArangoDB::OGM::Model::Timestamps

  include HasNotes
  include HasMentions
  include HasRoles
  include HasRecentActivity
  include HasWikipedia

  attribute :full_name, :string, validates: { presence: true }, normalizes: :default
  attribute :phonetic_full_name, :string, normalizes: :default

  attribute :formal_greeting, :string, normalizes: :default
  attribute :phonetic_formal_greeting, :string, normalizes: :default

  attribute :preferred_name, :string, normalizes: :default
  attribute :phonetic_preferred_name, :string, normalizes: :default

  attribute :vip, :boolean, default: false

  attribute :date_of_birth, :date
  attribute :anniversary,   :date

  attribute :email, :string, normalizes: [:strip, :blank, ->(val){ val.try(:downcase) || val }]

end