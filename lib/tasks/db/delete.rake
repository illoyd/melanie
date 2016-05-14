require 'colorize'

namespace :db do
  desc 'Drop the Orientdb database if it exists'
  task delete: :environment do

    # Initialize with a new database
    db = ArangoDB::API::Database.new

    print "Deleting #{ db.connection_uri.database }... "
    if db.exists?
      db.delete
      puts 'ok'.green
    else
      puts 'does not exist'.yellow
    end

  end
end