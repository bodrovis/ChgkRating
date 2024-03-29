# frozen_string_literal: true

RSpec.shared_examples_for 'an array' do
  it { is_expected.to respond_to :to_a }
end

RSpec.shared_examples_for 'not a hash' do
  it { is_expected.not_to respond_to :to_h }

  it {
    expect { subject.to_h }.to raise_error(ChgkRating::Error::NotHashType).
      with_message('This is not a hash-like collection, so it cannot be converted to an ordinary hash.')
  }
end

RSpec.shared_examples_for 'not an array' do
  it { is_expected.not_to respond_to :to_a }

  it {
    expect { subject.to_a }.to raise_error(ChgkRating::Error::NotArrayType).
      with_message('This is not an array-like collection, so it cannot be converted to an ordinary array.')
  }
end

RSpec.shared_examples_for 'a hash' do
  it { is_expected.to respond_to :to_h }
end

RSpec.shared_examples_for 'tournament team player' do
  specify('#id') { expect(player.id).to eq '51249' }
  specify('#is_captain') { expect(player.is_captain).to be true }
  specify('#is_base') { expect(player.is_base).to be true }
  specify('#is_foreign') { expect(player.is_foreign).to be false }
end

RSpec.shared_examples_for 'tournament team result' do
  specify('#result') do
    expect(team_result.result).to eq [false, false, false, false, true, true,
                                      true, false, false, true, false, false]
  end

  specify('#tour') { expect(team_result.tour).to eq 1 }
end

RSpec.shared_examples_for 'model without eager loading' do
  it 'raises an EagerLoadingNotSupported error' do
    expect { subject.eager_load! }.to raise_error(ChgkRating::Error::EagerLoadingNotSupported).
      with_message 'Eager loading is not supported for this resource.'
  end
end

RSpec.shared_examples_for 'model with eager loading' do
  it 'does not raise an EagerLoadingNotSupported error' do
    expect { subject.eager_load! }.not_to raise_error
  end
end

RSpec.shared_examples_for 'model without lazy support' do
  it { is_expected.not_to respond_to(:lazy) }

  it 'defines NO_LAZY_SUPPORT constant' do
    expect(subject.class::NO_LAZY_SUPPORT).to be true
  end
end

RSpec.shared_examples_for 'model with lazy support' do
  it { is_expected.to respond_to(:lazy) }

  it 'does not define NO_LAZY_SUPPORT constant' do
    klass = subject.class
    expect { klass::NO_LAZY_SUPPORT }.to raise_error(NameError).
      with_message "uninitialized constant #{klass}::NO_LAZY_SUPPORT"
  end
end
