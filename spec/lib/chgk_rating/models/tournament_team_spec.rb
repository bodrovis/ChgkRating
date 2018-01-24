RSpec.describe ChgkRating::Models::TournamentTeam do
  # this is always a lazily-loaded object as
  # we cannot get info about a specific team participating in a tournament!
  subject { described_class.new '52853', tournament_id: '3506', lazy: true }

  specify('#tournament_id') { expect(subject.tournament_id).to eq '3506' }
  specify('#id') { expect(subject.id).to eq '52853' }
end