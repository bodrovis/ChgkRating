describe URI do
  specify '.parse_safely' do
    expect(described_class.parse_safely('http://example.com/test').to_s).to eq('http://example.com/test')
    expect(described_class.parse_safely('gibberish').to_s).to eq 'gibberish'
    expect(described_class.parse_safely(nil)).to be_nil
  end
end