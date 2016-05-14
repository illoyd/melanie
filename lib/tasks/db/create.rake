namespace :db do
  desc 'Creates the Orientdb database given the current environment setup'
  task create: :environment do

    # Initialize with a new database
    db = Orientdb::ORM::Database.new

    print "Creating #{ db.connection_uri.database }... "
    unless db.exists?
      db.create
      puts 'ok'.green
    else
      puts 'already exists'.yellow
    end

  end
end
