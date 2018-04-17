RSpec.describe ChgkRating::Models::Rating do
  context 'player' do
    subject do
      VCR.use_cassette 'rating_player_release' do
        described_class.new 1336, player: 1000
      end
    end

    let(:rating_h) { subject.to_h }

    specify('#player') { expect(subject.player.id).to eq '1000' }
    specify('#release_id') { expect(subject.release_id).to eq '1336' }
    specify('#rating') { expect(subject.rating).to eq 7674 }
    specify('#rating_position') { expect(subject.rating_position).to eq 1417 }
    specify('#date') { expect(subject.date).to eq Date.new(2018, 04, 12) }
    specify('#tournaments_in_year') { expect(subject.tournaments_in_year).to eq 15 }
    specify('#tournament_count_total') { expect(subject.tournament_count_total).to eq 284 }
    specify '#to_h' do
      expect(rating_h['idplayer']).to eq '1000'
      expect(rating_h['tournaments_in_year']).to eq '15'
      expect(rating_h['tournament_count_total']).to eq '284'
    end
  end

  context 'team' do
    subject do
      VCR.use_cassette 'rating_release' do
        described_class.new 24, team: 1
      end
    end
    let(:rating_h) { subject.to_h }

    it_behaves_like 'model without eager loading'
    it_behaves_like 'model without lazy support'

    specify('#team') { expect(subject.team.id).to eq '1' }
    specify('#release_id') { expect(subject.release_id).to eq '24' }
    specify('#rating') { expect(subject.rating).to eq 9071 }
    specify('#rating_position') { expect(subject.rating_position).to eq 9 }
    specify('#date') { expect(subject.date).to eq Date.new(1999, 01, 07) }
    specify('#formula') { expect(subject.formula).to eq :b }

    specify '#to_h' do
      expect(rating_h['idteam']).to eq '1'
      expect(rating_h['idrelease']).to eq '24'
      expect(rating_h['rating']).to eq '9071'
      expect(rating_h['rating_position']).to eq '9'
      expect(rating_h['date']).to eq '1999-01-07'
      expect(rating_h['formula']).to eq 'b'
    end
  end
end