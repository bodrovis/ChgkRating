# frozen_string_literal: true

RSpec.describe ChgkRating::Models::Base do
  describe '.no_lazy_support!' do
    subject { klass.new }

    let!(:klass) do
      Class.new(described_class) do
        no_lazy_support!
        def initialize; end # rubocop:disable Style/RedundantInitialize
      end
    end

    it { is_expected.not_to respond_to(:lazy) }

    it 'defines NO_LAZY_SUPPORT constant' do
      expect(klass::NO_LAZY_SUPPORT).to be(true)
    end
  end

  describe '.no_eager_loading!' do
    subject { klass.new }

    let!(:klass) do
      Class.new(described_class) do
        no_eager_loading!
        def initialize; end # rubocop:disable Style/RedundantInitialize
      end
    end

    it 'raises an EagerLoadingNotSupported error' do
      expect { subject.eager_load! }.to raise_error(ChgkRating::Error::EagerLoadingNotSupported).
        with_message 'Eager loading is not supported for this resource.'
    end
  end
end
