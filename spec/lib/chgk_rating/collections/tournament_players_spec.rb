RSpec.describe ChgkRating::Collections::TournamentPlayers do
  subject do
    VCR.use_cassette 'team_players_at_tournament' do
      described_class.new(tournament_id: 3506, team_id: 52853)[0]
    end
  end

  it_behaves_like 'tournament team player'
end