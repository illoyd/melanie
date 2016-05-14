source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.beta1', '< 5.1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Use Puma as the app server
gem 'puma'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# ArangoDB OGM!
gem 'arangodb-api', '~> 0.1', github: 'illoyd/arangodb-api', branch: 'develop'
gem 'arangodb-ogm', '~> 0.1', github: 'illoyd/arangodb-ogm', branch: 'master'

# Additional tools, etc.
gem 'mail'
gem 'responders'
gem 'haml'
gem 'haml-contrib'
gem 'maruku'
gem 'sass'
gem 'colorize'
gem 'twitter-text'

# Activate draper gem
gem 'activemodel-serializers-xml', git: 'https://github.com/rails/activemodel-serializers-xml', ref: 'ad5ff3a'
gem 'draper', '~> 2.1', github: 'audionerd/draper', branch: 'rails5', ref: 'e816e0e5876b76c648c0928f1c3f2aa2c7a3d1f2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # RSpec
  %w[rspec rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, '>= 3.5.0.beta1', '< 3.6'
  end

  gem 'rspec-its'
  gem 'faker'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Guard and related plugins
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'fuubar', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
