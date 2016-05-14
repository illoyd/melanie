namespace :db do
  desc 'Creates the ArangoDB database given the current environment setup'
  task create: :environment do

    # Initialize with a new database
    db = ArangoDB::OGM.client.database

    print "Creating #{ ArangoDB::OGM.client.uri.database }... "
    unless db.exists?
      db.create
      puts 'ok'.green
    else
      puts 'already exists'.yellow
    end

  end
end
