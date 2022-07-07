# frozen_string_literal: true

require File.expand_path('lib/chgk_rating/version', __dir__)

Gem::Specification.new do |spec|
  spec.name                  = 'chgk_rating'
  spec.version               = ChgkRating::VERSION
  spec.authors               = ['Ilya Krukowski']
  spec.email                 = ['golosizpru@gmail.com']
  spec.summary               = 'Ruby interface to the competitive What? Where? When? rating API'
  spec.description           = 'Opinionated Ruby client for the competitive What? Where? When? ' \
                               'rating WebAPI (rating.chgk.info) that ' \
                               'allows to work with data as with Ruby objects'
  spec.homepage              = 'http://chgk-rating.bodrovis.tech/'
  spec.license               = 'MIT'
  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.6.0'

  spec.files = Dir['README.md', 'LICENSE', 'CONTRIBUTING.md',
                   'CHANGELOG.md', 'lib/**/*.rb', 'chgk_rating.gemspec', '.github/*.md',
                   'Gemfile', 'Rakefile']
  spec.extra_rdoc_files = ['README.md']
  spec.require_paths    = ['lib']

  spec.add_dependency 'faraday',                       '~> 2.0'
  spec.add_dependency 'faraday-follow_redirects',      '~> 0.3'
  spec.add_dependency 'multi_json',                    '~> 1.15'

  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0'
  spec.add_development_dependency 'rake',                      '~> 13.0'
  spec.add_development_dependency 'rspec',                     '~> 3.6'
  spec.add_development_dependency 'rubocop', '~> 1.31'
  spec.add_development_dependency 'rubocop-performance', '~> 1.5'
  spec.add_development_dependency 'rubocop-rspec',       '~> 2.11'
  spec.add_development_dependency 'vcr', '~> 6.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
