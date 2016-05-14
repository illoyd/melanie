require 'orientdb/orm'

##
# Organization class!
class Organization < Orientdb::ORM::V
  include Orientdb::ORM::HasTimestamps
  include Orientdb::ORM::HasEdges

  include HasNotes
  include HasMentions

  # Name, kind, default, validates
  attribute :name, :string
end