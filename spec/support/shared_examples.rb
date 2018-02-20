RSpec.shared_examples_for 'an array' do
  it { is_expected.to respond_to :to_a }
end

RSpec.shared_examples_for 'not a hash' do
  it { is_expected.not_to respond_to :to_h }
  it { expect( -> {subject.to_h} ).to raise_error(ChgkRating::Error::NotHashType).
      with_message('This is not a hash-like collection, so it cannot be converted to an ordinary hash.')}
end

RSpec.shared_examples_for 'not an array' do
  it { is_expected.not_to respond_to :to_a }
  it { expect( -> {subject.to_a} ).to raise_error(ChgkRating::Error::NotArrayType).
      with_message('This is not an array-like collection, so it cannot be converted to an ordinary array.')}
end

RSpec.shared_examples_for 'a hash' do
  it { is_expected.to respond_to :to_h }
end

RSpec.shared_examples_for 'tournament team player' do
  specify('#id') { expect(subject.id).to eq '51249' }
  specify('#is_captain') { expect(subject.is_captain).to eq true }
  specify('#is_base') { expect(subject.is_base).to eq true }
  specify('#is_foreign') { expect(subject.is_foreign).to eq false }
end

RSpec.shared_examples_for 'tournament team result' do
  specify('#result') { expect(subject.result).to eq [false, false, false, false, true, true,
                                                     true, false, false, true, false, false] }
  specify('#tour') { expect(subject.tour).to eq 1 }
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