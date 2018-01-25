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

RSpec.shared_examples_for 'model without eager loading' do
  it 'should raise an EagerLoadingNotSupported error' do
    expect( -> { subject.eager_load! }).to raise_error(ChgkRating::Error::EagerLoadingNotSupported).
        with_message 'Eager loading is not supported for this resource.'
  end
end

RSpec.shared_examples_for 'model with eager loading' do
  it 'should not raise an EagerLoadingNotSupported error' do
    expect( -> { subject.eager_load! }).not_to raise_error
  end
end

RSpec.shared_examples_for 'model without lazy support' do
  it { is_expected.not_to respond_to(:lazy) }

  it 'should define NO_LAZY_SUPPORT constant' do
    expect(subject.class::NO_LAZY_SUPPORT).to eq true
  end
end

RSpec.shared_examples_for 'model with lazy support' do
  it { is_expected.to respond_to(:lazy) }

  it 'should not define NO_LAZY_SUPPORT constant' do
    klass = subject.class
    expect( -> { klass::NO_LAZY_SUPPORT }).to raise_error(NameError).
        with_message "uninitialized constant #{klass}::NO_LAZY_SUPPORT"
  end
end