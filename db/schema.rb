# Schema for ArangoDB::OGM
require 'arangodb/ogm'

Graph = [
  {
    "collection" => Role.collection_name,
    "from"       => [ Person.collection_name ],
    "to"         => [ Organization.collection_name ]
  },
  {
    "collection" => Describe.collection_name,
    "from"       => [ Note.collection_name, Email.collection_name ],
    "to"         => [ Person.collection_name, Organization.collection_name ]
  },
  {
    "collection" => Mention.collection_name,
    "from"       => [ Note.collection_name, Email.collection_name ],
    "to"         => [ Hashtag.collection_name, Cashtag.collection_name ]
  },
  {
    "collection" => Send.collection_name,
    "from"       => [ Person.collection_name ],
    "to"         => [ Email.collection_name ]
  },
  {
    "collection" => ToReceive.collection_name,
    "from"       => [ Person.collection_name ],
    "to"         => [ Email.collection_name ]
  },
  {
    "collection" => CcReceive.collection_name,
    "from"       => [ Person.collection_name ],
    "to"         => [ Email.collection_name ]
  },
  {
    "collection" => BccReceive.collection_name,
    "from"       => [ Person.collection_name ],
    "to"         => [ Email.collection_name ]
  }
]

Documents = Graph.map { |d| d['from'] + d['to'] }.flatten.uniq
Edges = Graph.map { |d| d['collection'] }.flatten.uniq

Documents.each do |collection|
  cc = ArangoDB::OGM.client.collection(collection)
  cc.create unless cc.exists?
end

Edges.each do |collection|
  cc = ArangoDB::OGM.client.collection(collection)
  cc.create('type' => ArangoDB::API::Collection::Edge) unless cc.exists?
end

if ArangoDB::OGM.graph.exists?
  # ArangoDB::OGM.graph.update("edgeDefinitions" => Graph)
else
  ArangoDB::OGM.graph.create("edgeDefinitions" => Graph)
end


# # Check if database is configured
# Orientdb::ORM.with do |orm|
#   orm.connect unless orm.connected?
#   client = orm.client
#
#   # Create Person class
#   unless orm.client.class_exists? Person.name
#     client.create_class(Person, extends: 'V') do |c|
#       c.property 'full_name',  :string, notnull: true, mandatory: true
#       c.property 'phonetic_full_name', :string
#       c.property 'emails', :embeddedset
#     end
#   end
#
#   # Create Note class
#   unless orm.client.class_exists? Note.name
#     client.create_class(Note.name, extends: 'V') do |c|
#       c.property 'body', :string, notnull: true, mandatory: true
#
#       c.link 'created_by', :link, Person.name, notnull: true, mandatory: true
#       c.link 'updated_by', :link, Person.name, notnull: true, mandatory: true
#     end
#   end
#
#   # Create Email class, as a subset of Note
#   unless orm.client.class_exists? Email.name
#     client.create_class(Email.name, extends: Note.name) do |c|
#       c.property 'message_id', :string, notnull: true, mandatory: true
#       c.property 'subject', :string, notnull: true, mandatory: true
#     end
#   end
#
#   # Create Organization class
#   unless orm.client.class_exists? Organization.name
#     client.create_class(Organization.name, extends: 'V') do |c|
#       c.property 'name', :string, notnull: true, mandatory: true
#     end
#   end
#
#   # Create Hashtag class
#   unless orm.client.class_exists? Hashtag.name
#     client.create_class(Hashtag.name, extends: 'V') do |c|
#       c.property 'text', :string, notnull: true, mandatory: true
#     end
#   end
#
#   # Create Cashtag class
#   unless orm.client.class_exists? Cashtag.name
#     client.create_class(Cashtag.name, extends: 'V') do |c|
#       c.property 'text', :string, notnull: true, mandatory: true
#       c.link 'organization', :link, Organization.name, notnull: true, mandatory: true
#     end
#   end
#
#   # Create NYSECashtag class
#   unless orm.client.class_exists? NYSECashtag.name
#     client.create_class(NYSECashtag.name, extends: 'Cashtag') do |c|
#     end
#   end
#
#   # Create LSECashtag class
#   unless orm.client.class_exists? LSECashtag.name
#     client.create_class(LSECashtag.name, extends: 'Cashtag') do |c|
#     end
#   end
#
#   # Create Role edge
#   unless orm.client.class_exists? Role.name
#     client.create_class(Role.name, extends: 'E') do |c|
#       c.property 'title',  :string
#       c.link 'out', :link, Person.name
#       c.link 'in',  :link, Organization.name
#     end
#   end
#
#   # Create Describes edge
#   unless orm.client.class_exists? Describes.name
#     client.create_class(Describes.name, extends: 'E') do |c|
#       c.link 'out', :link, Note.name
#     end
#   end
#
#   # Create Mentions edge
#   unless orm.client.class_exists? Mentions.name
#     client.create_class(Mentions.name, extends: 'E') do |c|
#       # TODO: Any properties for Mentions edge
#     end
#   end
#
#   # Create Sends edge
#   unless orm.client.class_exists? Sends.name
#     client.create_class(Sends.name, extends: 'E') do |c|
#       # TODO: Any properties for Mentions edge
#     end
#   end
#
#   # Create Receives edge
#   unless orm.client.class_exists? Receives.name
#     client.create_class(Receives.name, extends: 'E') do |c|
#     end
#   end
#
#   # Create Receives To edge
#   unless orm.client.class_exists? ReceivesTo.name
#     client.create_class(ReceivesTo.name, extends: Receives.name) do |c|
#     end
#   end
#
#   # Create Receives CC edge
#   unless orm.client.class_exists? ReceivesCc.name
#     client.create_class(ReceivesCc.name, extends: Receives.name) do |c|
#     end
#   end
#
#   # Create Receives BCC edge
#   unless orm.client.class_exists? ReceivesBcc.name
#     client.create_class(ReceivesBcc.name, extends: Receives.name) do |c|
#     end
#   end
# end