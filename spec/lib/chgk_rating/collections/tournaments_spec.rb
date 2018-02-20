RSpec.describe ChgkRating::Collections::Tournaments do
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
      expect(tournaments_arr[10]['idtournament']).to eq '3467'
    end
    specify('#id') { expect(tournament.id).to eq '4592' }
    specify('#name') { expect(tournament.name).to eq 'Гран-при Бауманки. Синхрон' }
    specify('#date_start') { expect(tournament.date_start).to eq DateTime.parse('2017-10-29 10:00:00') }
    specify('#date_end') { expect(tournament.date_end).to eq DateTime.parse('2018-08-23 10:00:00') }
    specify('#type_name') { expect(tournament.type_name).to eq 'Общий зачёт' }
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
      expect(subject.to_h['7'][0]['idtournament']).to eq '367'
    end
    specify('#id') { expect(tournament.id).to eq '424' }
  end
end