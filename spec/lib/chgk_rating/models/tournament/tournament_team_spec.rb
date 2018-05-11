RSpec.describe ChgkRating::Models::TournamentTeam do
  # this is always a lazily-loaded object as
  # we cannot get info about a specific team participating in a tournament!
  subject { described_class.new '52853', tournament: '3506', lazy: true }
  let(:tournament_team_h) { subject.to_h }

  it_behaves_like 'model without eager loading'
  it_behaves_like 'model with lazy support'

  specify('#tournament') { expect(subject.tournament.id).to eq '3506' }
  specify('#team') { expect(subject.team.id).to eq '52853' }
  specify('#id') { expect(subject.id).to eq '52853' }
  specify '#to_h' do
    expect(tournament_team_h['idteam']).to eq '52853'
  end

  describe '#players' do
    let(:players) do
      VCR.use_cassette 'team_players_at_tournament' do
        subject.players
      end
    end

    it { expect(players).to be_an_instance_of ChgkRating::Collections::TournamentTeamPlayers }
  end

  describe '#results' do
    let(:results) do
      VCR.use_cassette 'team_results_at_tournament' do
        subject.results
      end
    end

    it { expect(results).to be_an_instance_of ChgkRating::Collections::TournamentTeamResults }
  end
end