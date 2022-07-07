# frozen_string_literal: true

RSpec.describe ChgkRating::Collections::TeamRatings do
  subject do
    VCR.use_cassette 'team_ratings' do
      described_class.new(team: 1)
    end
  end

  let(:ratings) do
    subject[0]
  end

  it_behaves_like 'not a hash'
  it_behaves_like 'an array'

  specify '#to_a' do
    ratings_arr = subject.to_a
    expect(ratings_arr.count).to eq 572
    expect(ratings_arr[500]['date']).to eq '2006-08-17'
  end

  specify('#date') { expect(ratings.date.to_s).to eq '2003-07-01' }
  specify('#formula') { expect(ratings.formula).to eq :a }
  specify('#rating_position') { expect(ratings.rating_position).to eq 8 }
  specify('#release_id') { expect(ratings.release_id).to eq '1' }
  specify('#team') { expect(ratings.team.id).to eq '1' }
  specify('#rating') { expect(ratings.rating).to eq 6093 }
end
