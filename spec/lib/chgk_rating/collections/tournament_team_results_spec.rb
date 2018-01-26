RSpec.describe ChgkRating::Collections::TournamentTeamResults do
  subject do
    VCR.use_cassette 'team_results_at_tournament' do
      described_class.new(tournament_id: 3506, team_id: 52853)[0]
    end
  end

  it_behaves_like 'tournament team result'
end