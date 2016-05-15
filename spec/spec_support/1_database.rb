ENV['ARANGODB_PROVIDER'] = 'ARANGODB_TEST'
ArangoDB::OGM.client.uri = ENV['ARANGODB_URI'] = ENV[ENV['ARANGODB_PROVIDER']]
ArangoDB::OGM.graph_name = ENV['ARANGODB_GRAPH'] = 'melanie_test'

$strategy = ArangoDB::Test::Strategy.new(client: ArangoDB::OGM.client)

RSpec.configure do |config|
  config.before(:suite) { $strategy.before_suite }
  config.before(:suite) { load './db/schema.rb' }
  config.before(:each)  { $strategy.before_spec }
  config.after(:each)   { $strategy.after_spec }
  config.after(:suite)  { $strategy.after_suite }
end
