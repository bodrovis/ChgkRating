# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.ignore_hosts 'codeclimate.com'
  c.hook_into :faraday
  c.cassette_library_dir = File.join(File.dirname(__FILE__), '..', 'fixtures', 'vcr_cassettes')
  c.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end
end
