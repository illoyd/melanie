require 'colorize'

namespace :db do
  desc 'Build the schema; this simply calls to config/db/schema.rb'
  task schema: :environment do
    print 'Loading schema... '
    require './db/schema'
    puts 'ok'.green
  end
end