ENV['ARANGODB_PROVIDER'] = 'ARANGODB_TEST'
ENV['ARANGODB_GRAPH'] = 'melanie_test'

$strategy = ArangoDB::Test::Strategy.new(client: ArangoDB::Client.new)

RSpec.configure do |config|
  config.before(:suite) { $strategy.before_suite }
  config.before(:suite) { load './db/schema.rb' }
  config.before(:each)  { $strategy.before_spec }
  config.after(:each)   { $strategy.after_spec }
  config.after(:suite)  { $strategy.after_suite }
end
