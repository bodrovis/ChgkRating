describe ChgkRating::Utils::BooleanParser do
  subject { Class.new.include(described_class).new }

  specify '#to_boolean' do
    expect(subject.to_boolean('1')).to eq(true)
    expect(subject.to_boolean('0')).to eq(false)
    expect(subject.to_boolean(1)).to eq(true)
    expect(subject.to_boolean(0)).to eq(false)
  end
end