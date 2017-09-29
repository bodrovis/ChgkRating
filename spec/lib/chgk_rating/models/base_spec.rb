RSpec.describe ChgkRating::Models::Base do
  describe '.no_lazy_support!' do
    let!(:klass) do
      Class.new(described_class) do
        no_lazy_support!
        def initialize ; end
      end
    end

    subject { klass.new }

    it { should_not respond_to(:lazy) }

    it 'should define NO_LAZY_SUPPORT constant' do
      expect(klass::NO_LAZY_SUPPORT).to eq(true)
    end
  end

  describe '.no_eager_loading!' do
    let!(:klass) do
      Class.new(described_class) do
        no_eager_loading!
        def initialize ; end
      end
    end

    subject { klass.new }

    it 'should raise an EagerLoadingNotSupported error' do
      expect( -> { subject.eager_load! }).to raise_error(ChgkRating::Error::EagerLoadingNotSupported)
    end
  end
end