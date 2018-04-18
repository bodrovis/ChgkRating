RSpec.describe ChgkRating::Collections::Tournaments do
  context 'all tournaments for a player' do
    subject do
      VCR.use_cassette 'player_tournaments' do
        described_class.new(player: 1000)
      end
    end
    let(:tournament) { subject['3'][0] }

    specify '#to_h' do
      subject_h = subject.to_h['6']
      expect(subject_h['tournaments'][0]['idtournament']).to eq '220'
      expect(subject_h['tournaments'][0]['in_base_team']).to eq '1'
      expect(subject_h['tournaments'][0]['idteam']).to eq '233'
      expect(subject_h['idplayer']).to eq '1000'
    end
    specify('#id') { expect(tournament.id).to eq '91' }
  end

  context 'all tournaments for a player by season' do
    subject do
      VCR.use_cassette 'player_tournaments_season' do
        described_class.new(player: 1000, season_id: 51)
      end
    end
    let(:tournament) { subject[0] }

    specify '#to_a' do
      tournaments_arr = subject.to_a
      expect(tournaments_arr[2]['idtournament']).to eq '4782'
    end
    specify('#id') { expect(tournament.id).to eq '4712' }
    specify('#team') { expect(tournament.team.id).to eq '51284' }
    specify('#in_base_team') { expect(tournament.in_base_team).to eq false }
    specify('#player') { expect(subject.player.id).to eq 1000 }
    specify('#season_id') { expect(subject.season_id).to eq 51 }
  end

  context 'all tournaments for a team by season' do
    subject do
      VCR.use_cassette 'team_tournaments_season' do
        described_class.new(team: 1, season_id: 4)
      end
    end

    it_behaves_like 'not a hash'
    it_behaves_like 'an array'

    specify '#to_a' do
      tournaments_arr = subject.to_a
      expect(tournaments_arr[2]['idtournament']).to eq '150'
    end
    specify('#id') { expect(subject[0].id).to eq '188' }
    specify('#team') { expect(subject.team.id).to eq 1 }
    specify('#season_id') { expect(subject.season_id).to eq 4 }
  end

  context 'all tournaments' do
    subject do
      VCR.use_cassette 'tournaments' do
        described_class.new
      end
    end
    let(:tournament) { subject[0] }

    it_behaves_like 'not a hash'
    it_behaves_like 'an array'

    specify '#to_a' do
      tournaments_arr = subject.to_a
      expect(tournaments_arr[10]['idtournament']).to eq '1538'
    end
    specify('#id') { expect(tournament.id).to eq '1908' }
    specify('#name') { expect(tournament.name).to eq 'Фестиваль в Мариуполе' }
    specify('#date_start') { expect(tournament.date_start).to eq DateTime.parse('1989-09-01 00:00:00') }
    specify('#date_end') { expect(tournament.date_end).to eq DateTime.parse('1989-09-03 00:00:00') }
    specify('#type_name') { expect(tournament.type_name).to eq 'Обычный' }
  end

  context 'tournaments for a team' do
    subject do
      VCR.use_cassette 'team_tournaments' do
        described_class.new(team: 1)
      end
    end
    let(:tournament) { subject['8'][0] }

    it_behaves_like 'a hash'
    it_behaves_like 'not an array'

    specify '#to_h' do
      subject_h = subject.to_h['7']
      expect(subject_h['tournaments'][0]['idtournament']).to eq '367'
      expect(subject_h['idseason']).to eq '7'
      expect(subject_h['idteam']).to eq '1'
    end
    specify('#id') { expect(tournament.id).to eq '424' }
  end
end