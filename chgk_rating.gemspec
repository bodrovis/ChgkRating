require File.expand_path('../lib/chgk_rating/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name                  = 'chgk_rating'
  spec.version               = ChgkRating::VERSION
  spec.authors               = ['Ilya Bodrov']
  spec.email                 = ['golosizpru@gmail.com']
  spec.summary               = 'Ruby interface to the competitive What? Where? When? rating API'
  spec.description           = 'Opinionated Ruby client for the competitive What? Where? When? rating WebAPI (rating.chgk.info) that allows to work with data as with Ruby objects'
  spec.homepage              = 'http://chgk-rating.bodrovis.tech/'
  spec.license               = 'MIT'
  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.4.0'

  spec.files            =  Dir["README.md", "LICENSE", "CONTRIBUTING.md",
                               "CHANGELOG.md", "lib/**/*.rb", "chgk_rating.gemspec", ".github/*.md",
                               "Gemfile", "Rakefile"]
  spec.test_files       = Dir["spec/**/*.rb"]
  spec.extra_rdoc_files = ['README.md']
  spec.require_paths    = ['lib']

  spec.add_dependency 'faraday',                       '~> 0.13'
  spec.add_dependency 'multi_json',                    '~> 1.12'

  spec.add_development_dependency 'rake',                      '~> 12.1'
  spec.add_development_dependency 'rspec',                     '~> 3.6'
  spec.add_development_dependency 'vcr',                       '~> 4.0'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0'
end