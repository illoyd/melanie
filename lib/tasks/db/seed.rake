namespace :db do
  desc 'Inject the seed environment; this simply calls to config/db/seed.rb'
  task seed: :environment do
    print 'Loading seeds... '
    require './db/seeds'
    puts 'ok'.green
  end
end