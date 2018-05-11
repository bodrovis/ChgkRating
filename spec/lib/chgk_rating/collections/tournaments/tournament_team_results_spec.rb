RSpec.describe ChgkRating::Collections::TournamentTeamResults do
  subject do
    VCR.use_cassette 'team_results_at_tournament' do
      described_class.new(tournament: 3506, team: 52853)
    end
  end

  it_behaves_like 'tournament team result' do
    let(:team_result) { subject[0] }
  end
  it_behaves_like 'not a hash'
  it_behaves_like 'an array'

  specify '#to_a' do
    expect(subject.to_a[2]['tour']).to eq '3'
  end
end