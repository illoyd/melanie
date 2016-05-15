require 'colorize'

namespace :db do
  desc 'Drop the Arangodb database if it exists'
  task delete: :environment do

    # Initialize with a new database
    db = ArangoDB::OGM.client.database

    print "Deleting #{ ArangoDB::OGM.client.uri.database }... "
    if db.exists?
      db.destroy
      puts 'ok'.green
    else
      puts 'does not exist'.yellow
    end

  end
end