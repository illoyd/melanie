require 'rails_helper'

# Objects in schema space
#ENV['ARANGODB_PROVIDER'] = 'TEST_DATABASE_URL'
ENV['ARANGODB_URI'] = 'arangodb://localhost/melanie_test'
DATABASE_CLASSES = [ Cashtag, Describes, Hashtag, Mentions, Note, Email, Organization, Person, Role ].map(&:collection_name)

# Create database
def create_database
  client = ArangoDB::Client.new
  client.uri.database = ''
  client.database.create('melanie_test') unless client.database.exists?('melanie_test')
  load './db/schema.rb'
end

# Drop database
def drop_database
  client = ArangoDB::Client.new
  client.uri.database = ''
  client.database.drop('melanie_test') if client.database.exists?('melanie_test')
end

# Create database classes
def create_database_classes
  endpoint = ArangoDB::Client.new.collection
  DATABASE_CLASSES.each do |collection|
    endpoint.create(collection) unless endpoint.exists?(collection)
  end
end

# Drop database classes
def clear_database_classes
  endpoint = ArangoDB::Client.new.collection
  DATABASE_CLASSES.each do |collection|
    endpoint.truncate(collection) if endpoint.exists?(collection)
  end
end

RSpec.shared_context "with database", :with_database => true do
  before(:all)  { create_database }
  before(:all)  { create_database_classes }
  before(:each) { clear_database_classes }
  after(:all)   { drop_database }
end
