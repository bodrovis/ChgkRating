RSpec.describe ChgkRating::Collections::Ratings do
  subject do
    VCR.use_cassette 'team_ratings' do
      described_class.new(team_id: 1)[0]
    end
  end

  specify('#date') { expect(subject.date.to_s).to eq '2003-07-01' }
  specify('#formula') { expect(subject.formula).to eq :a }
  specify('#rating_position') { expect(subject.rating_position).to eq 8 }
  specify('#release_id') { expect(subject.release_id).to eq '1' }
  specify('#team') { expect(subject.team.id).to eq '1' }
  specify('#rating') { expect(subject.rating).to eq 6093 }
end