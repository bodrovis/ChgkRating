RSpec.describe ChgkRating::Collections::TournamentTeamPlayers do
  subject do
    VCR.use_cassette 'team_players_at_tournament' do
      described_class.new(tournament: 3506, team: 52853)
    end
  end


  it_behaves_like 'tournament team player' do
    let(:player) { subject[0] }
  end
  it_behaves_like 'not a hash'
  it_behaves_like 'an array'

  specify '#to_a' do
    expect(subject.to_a[2]['idplayer']).to eq '51250'
  end
end