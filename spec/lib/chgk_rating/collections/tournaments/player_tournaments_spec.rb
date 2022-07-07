# frozen_string_literal: true

RSpec.describe ChgkRating::Collections::PlayerTournaments do
  context 'all tournaments for a player' do
    subject do
      VCR.use_cassette 'player_tournaments' do
        described_class.new(player: 1000)
      end
    end

    let(:player_tournament) { subject['3'][0] }

    specify '#to_h' do
      subject_h = subject.to_h['6']
      expect(subject_h['tournaments'][0]['idtournament']).to eq '220'
      expect(subject_h['tournaments'][0]['in_base_team']).to eq '1'
      expect(subject_h['tournaments'][0]['idteam']).to eq '233'
      expect(subject_h['idplayer']).to eq '1000'
    end

    specify('#tournament') { expect(player_tournament.tournament.id).to eq '91' }
  end

  context 'all tournaments for a player by season' do
    subject do
      VCR.use_cassette 'player_tournaments_season' do
        described_class.new(player: 1000, season_id: 51)
      end
    end

    let(:player_tournament) { subject[0] }

    specify '#to_a' do
      tournaments_arr = subject.to_a
      expect(tournaments_arr[2]['idtournament']).to eq '4782'
    end

    specify('#tournament') { expect(player_tournament.tournament.id).to eq '4712' }
    specify('#team') { expect(player_tournament.team.id).to eq '51284' }
    specify('#in_base_team') { expect(player_tournament.in_base_team).to be false }
    specify('#player') { expect(subject.player.id).to eq 1000 }
    specify('#season_id') { expect(subject.season_id).to eq 51 }
  end
end
