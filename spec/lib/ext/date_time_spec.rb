RSpec.describe DateTime do
  subject { DateTime.new(2018,01,24,16,58,34) }

  specify '#to_s_chgk' do
    expect(subject.to_s_chgk).to eq '2018-01-24 16:58:34'
  end

  specify '.parse_safely' do
    expect(described_class.parse_safely('2017-09-28 12:00:33').to_s).to eq('2017-09-28T12:00:33+00:00')
  end
end