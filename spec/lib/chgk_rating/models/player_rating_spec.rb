# frozen_string_literal: true

RSpec.describe ChgkRating::Models::PlayerRating do
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
  specify('#date') { expect(subject.date).to eq Date.new(2018, 0o4, 12) }
  specify('#tournaments_in_year') { expect(subject.tournaments_in_year).to eq 15 }
  specify('#tournament_count_total') { expect(subject.tournament_count_total).to eq 284 }

  specify '#to_h' do
    expect(rating_h['idplayer']).to eq '1000'
    expect(rating_h['tournaments_in_year']).to eq '15'
    expect(rating_h['tournament_count_total']).to eq '284'
  end
end
