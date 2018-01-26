require 'simplecov'
SimpleCov.start do
  add_filter "spec/"
end

require 'chgk_rating'

# Support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include TestClient
end