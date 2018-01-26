RSpec.describe ChgkRating::Collections::Recaps do
  subject do
    VCR.use_cassette 'recaps' do
      described_class.new(team_id: 1)['6']
    end
  end

  specify('#season_id') { expect(subject.season_id).to eq '6' }
  specify('#team') { expect(subject.team.id).to eq '1' }
  specify('#captain') { expect(subject.captain.id).to eq '2935' }
  specify('#players') { expect(subject.players.first.id).to eq '1585' }
end