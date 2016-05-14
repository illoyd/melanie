# config/initalizers/arangodb.rb

if defined?(ArangoDB::OGM)
  # GlobalID is used by ActiveJob (among other things)
  # https://github.com/rails/globalid

  ArangoDB::OGM::Document.send(:include, GlobalID::Identification)

  # Error if a URI is not provided
  if ArangoDB::OGM.client.uri.nil?
    raise RuntimeError, 'ArangoDB URI not defined.'
  end

  # Error if database is not initialised and available
#   unless ArangoDB::API::Database.new(ArangoDB::OGM.client).exists?
#     raise RuntimeError, "Could not find ArangoDB database '#{ ArangoDB::OGM.client.database_name }'."
#   end

end