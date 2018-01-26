require File.expand_path('../lib/chgk_rating/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name                  = 'chgk_rating'
  spec.version               = ChgkRating::VERSION
  spec.authors               = ['Ilya Bodrov']
  spec.email                 = ['golosizpru@gmail.com']
  spec.summary               = 'Ruby interface to the competitive What? Where? When? rating API'
  spec.description           = 'Ruby client for the competitive What? Where? When? rating WebAPI (rating.chgk.info)'
  spec.homepage              = 'https://github.com/bodrovis/chgk_rating'
  spec.license               = 'MIT'
  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.3.0'

  spec.files            = `git ls-files`.split('\n')
  spec.test_files       = `git ls-files -- {test,spec,features}/*`.split('\n')
  spec.extra_rdoc_files = ['README.md']
  spec.require_paths    = ['lib']

  spec.add_runtime_dependency 'faraday',                       '~> 0.13'
  spec.add_runtime_dependency 'multi_json',                    '~> 1.12'

  spec.add_development_dependency 'rake',                      '~> 12.1'
  spec.add_development_dependency 'rspec',                     '~> 3.6'
  spec.add_development_dependency 'vcr',                       '~> 4.0'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0'
end