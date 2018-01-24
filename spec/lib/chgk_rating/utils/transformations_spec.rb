describe ChgkRating::Utils::Transformations do
  specify '.to_boolean' do
    expect(described_class.send(:to_boolean).call('1')).to eq(true)
    expect(described_class.send(:to_boolean).call('0')).to eq(false)
  end

  specify '.to_binary_boolean' do
    expect(described_class.send(:to_binary_boolean).call(true)).to eq('1')
    expect(described_class.send(:to_binary_boolean).call(false)).to eq('0')
  end

  specify '.to_star' do
    expect(described_class.send(:to_star, :to_i).call('1')).to eq(1)
    expect(described_class.send(:to_star, :to_sym, true).call(%w(one two apple))).to eq(%i(one two apple))
  end
end