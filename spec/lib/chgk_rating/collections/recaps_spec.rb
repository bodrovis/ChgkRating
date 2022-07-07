# frozen_string_literal: true

RSpec.describe ChgkRating::Collections::Recaps do
  subject do
    VCR.use_cassette 'recaps' do
      described_class.new(team: 1)
    end
  end

  let(:recaps) { subject['6'] }

  it_behaves_like 'a hash'
  it_behaves_like 'not an array'

  specify '#to_h' do
    recaps_h = subject.to_h
    expect(recaps_h['6']['idseason']).to eq '6'
    expect(recaps_h['6']['captain']).to eq '2935'
  end

  specify('#season_id') { expect(recaps.season_id).to eq '6' }
  specify('#team') { expect(recaps.team.id).to eq '1' }
  specify('#captain') { expect(recaps.captain.id).to eq '2935' }
  specify('#players') { expect(recaps.players.first.id).to eq '1585' }
end
