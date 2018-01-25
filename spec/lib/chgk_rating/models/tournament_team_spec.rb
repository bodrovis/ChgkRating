RSpec.describe ChgkRating::Models::TournamentTeam do
  # this is always a lazily-loaded object as
  # we cannot get info about a specific team participating in a tournament!
  subject { described_class.new '52853', tournament_id: '3506', lazy: true }
  let(:tournament_team_h) { subject.to_h }

  it_behaves_like 'model without eager loading'
  it_behaves_like 'model with lazy support'

  specify('#tournament_id') { expect(subject.tournament_id).to eq '3506' }
  specify('#id') { expect(subject.id).to eq '52853' }
  specify '#to_h' do
    expect(tournament_team_h['idteam']).to eq '52853'
  end
end