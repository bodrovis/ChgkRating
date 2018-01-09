describe DateTime do
  specify '.parse_safely' do
    expect(described_class.parse_safely('2017-09-28 12:00:33').to_s).to eq('2017-09-28T12:00:33+00:00')
    expect(described_class.parse_safely('gibberish')).to be_nil
    expect(described_class.parse_safely(nil)).to be_nil
  end
end