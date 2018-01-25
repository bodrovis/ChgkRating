RSpec.describe ChgkRating::Models::Recap do
  subject do
    VCR.use_cassette 'recap_last_season' do
      described_class.new :last, team_id: 7931
    end
  end
  let(:recap_h) { subject.to_h }

  it_behaves_like 'model without eager loading'
  it_behaves_like 'model without lazy support'

  specify('#season_id') { expect(subject.season_id).to eq '51' }
  specify('#team') { expect(subject.team.id).to eq '7931' }
  specify('#captain') { expect(subject.captain.id).to eq '23539' }
  specify('#players') { expect(subject.players.first.id).to eq '2668' }
  specify '#to_h' do
    expect(recap_h['idseason']).to eq '51'
    expect(recap_h['idteam']).to eq '7931'
    expect(recap_h['captain']).to eq '23539'
    expect(recap_h['players']).to eq ["2668", "6654", "23539", "53735", "94783", "98697", "115867"]
  end

  context 'with season number' do
    subject do
      VCR.use_cassette 'recap' do
        described_class.new 9, team_id: 1
      end
    end

    specify('#season_id') { expect(subject.season_id).to eq '9' }
    specify('#team') { expect(subject.team.id).to eq '1' }
    specify('#captain') { expect(subject.captain.id).to eq '2935' }
    specify('#players') { expect(subject.players.first.id).to eq '2935' }
  end
end