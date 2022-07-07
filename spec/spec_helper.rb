# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
  add_filter '.github/'
  add_filter 'docs/'
end

require 'chgk_rating'

# Support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.include TestClient
  config.raise_errors_for_deprecations!
end
