RSpec.describe ChgkRating::Models::TournamentTeamResult do
  subject do
    VCR.use_cassette 'team_results_at_tournament' do
      test_client.team_results_at_tournament(3506, 52853)[0]
    end
  end
  let(:tournament_team_result_h) { subject.to_h }

  it_behaves_like 'model without eager loading'
  it_behaves_like 'model without lazy support'
  it_behaves_like 'tournament team result' do
    let(:team_result) { subject }
  end

  specify '#to_h' do
    expect(tournament_team_result_h['tour']).to eq '1'
    expect(tournament_team_result_h['mask']).to eq %w(0 0 0 0 1 1 1 0 0 1 0 0)
  end
end