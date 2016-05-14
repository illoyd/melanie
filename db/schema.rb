# Schema for ArangoDB::OGM
require 'arangodb/ogm'

configuration = [
  {
    "collection" => Role.collection_name,
    "from"       => [ Person.collection_name ],
    "to"         => [ Organization.collection_name ]
  },
  {
    "collection" => Describes.collection_name,
    "from"       => [ Note.collection_name, Email.collection_name ],
    "to"         => [ Person.collection_name, Organization.collection_name ]
  },
  {
    "collection" => Mentions.collection_name,
    "from"       => [ Note.collection_name, Email.collection_name ],
    "to"         => [ Hashtag.collection_name, Cashtag.collection_name ]
  },
  {
    "collection" => Sends.collection_name,
    "from"       => [ Person.collection_name ],
    "to"         => [ Email.collection_name ]
  },
  {
    "collection" => ReceivesTo.collection_name,
    "from"       => [ Person.collection_name ],
    "to"         => [ Email.collection_name ]
  },
  {
    "collection" => ReceivesCc.collection_name,
    "from"       => [ Person.collection_name ],
    "to"         => [ Email.collection_name ]
  },
  {
    "collection" => ReceivesBcc.collection_name,
    "from"       => [ Person.collection_name ],
    "to"         => [ Email.collection_name ]
  }
]

if ArangoDB::OGM.client.graph.get.body['result'].include?(ArangoDB::OGM.graph_name)
  ArangoDB::OGM.graph.put("edgeDefinitions" => configuration)
else
  ArangoDB::OGM.client.graph.post('name' => ArangoDB::OGM.graph_name, "edgeDefinitions" => configuration)
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