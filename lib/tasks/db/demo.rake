namespace :db do
  desc 'Inject the demo environment; this simply calls to config/db/demo.rb'
  task demo: :environment do
    print 'Loading demo... '
    require './db/demo'
    puts 'ok'.green
  end
end