RSpec.describe ChgkRating::Collections::Ratings do
  context 'player' do
    subject do
      VCR.use_cassette 'player_ratings' do
        described_class.new(player: 1000)[-1]
      end
    end

    specify('#player') { expect(subject.player.id).to eq '1000' }
    specify('#release_id') { expect(subject.release_id).to eq '1336' }
    specify('#rating') { expect(subject.rating).to eq 7674 }
    specify('#rating_position') { expect(subject.rating_position).to eq 1417 }
    specify('#date') { expect(subject.date).to eq Date.new(2018, 04, 12) }
    specify('#tournaments_in_year') { expect(subject.tournaments_in_year).to eq 15 }
    specify('#tournament_count_total') { expect(subject.tournament_count_total).to eq 284 }
  end

  context 'team' do
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
end