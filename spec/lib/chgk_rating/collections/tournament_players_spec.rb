RSpec.describe ChgkRating::Collections::TournamentPlayers do
  subject do
    VCR.use_cassette 'team_players_at_tournament' do
      described_class.new(tournament_id: 3506, team_id: 52853)[0]
    end
  end

  specify('#id') { expect(subject.id).to eq '51249' }
  specify('#is_captain') { expect(subject.is_captain).to eq true }
  specify('#is_base') { expect(subject.is_base).to eq true }
  specify('#is_foreign') { expect(subject.is_foreign).to eq false }
end