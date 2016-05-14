require 'rails_helper'

# Objects in schema space
ENV['DATABASE_PROVIDER'] = 'TEST_DATABASE_URL'
SCHEMA_OBJECTS = %w( Cashtag Describes Hashtag Mentions Note Email Organization Person Role ).freeze

# Create the test database
def create_database
  options = { database: Orientdb::ORM.connection_uri.database, user: Orientdb::ORM.connection_uri.user, password: Orientdb::ORM.connection_uri.password, type: :graph, storage: :memory }
  Orientdb::ORM.with do |conn|
    conn.client.create_database( options )
    #conn.command( "ALTER DATABASE DATETIMEFORMAT yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" )
  end
end

# Drop the test database
def drop_database
  options = { database: Orientdb::ORM.connection_uri.database, user: Orientdb::ORM.connection_uri.user, password: Orientdb::ORM.connection_uri.password }
  Orientdb::ORM.with { |conn| conn.client.delete_database( options ) }
end

# Create database classes
def load_schema
  load './db/schema.rb'
end

# Truncate the entire database tree... very unsafe!
def clean_schema
  Orientdb::ORM.with do |conn|
    SCHEMA_OBJECTS.each { |obj| conn.command( "TRUNCATE CLASS #{ obj } POLYMORPHIC UNSAFE" ) }
  end
end

RSpec.shared_context "with database", :with_database => true do
  before(:all)  { create_database }
  before(:all)  { load_schema }
  before(:each) { clean_schema }
  after(:all)   { drop_database }
end
