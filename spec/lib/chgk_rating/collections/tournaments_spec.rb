RSpec.describe ChgkRating::Collections::Tournaments do
  context 'all tournaments for a team by season' do
    subject do
      VCR.use_cassette 'team_tournaments_season' do
        described_class.new(team: 1, season_id: 4)
      end
    end

    specify('#id') { expect(subject[0].id).to eq '188' }
    specify('#team') { expect(subject.team.id).to eq 1 }
    specify('#season_id') { expect(subject.season_id).to eq 4 }
  end

  context 'all tournaments' do
    subject do
      VCR.use_cassette 'tournaments' do
        described_class.new[0]
      end
    end

    specify('#id') { expect(subject.id).to eq '4592' }
    specify('#name') { expect(subject.name).to eq 'Гран-при Бауманки. Синхрон' }
    specify('#date_start') { expect(subject.date_start).to eq DateTime.parse('2017-10-29 10:00:00') }
    specify('#date_end') { expect(subject.date_end).to eq DateTime.parse('2018-08-23 10:00:00') }
    specify('#type_name') { expect(subject.type_name).to eq 'Общий зачёт' }
  end

  context 'tournaments for a team' do
    subject do
      VCR.use_cassette 'team_tournaments' do
        described_class.new(team: 1)['8'][0]
      end
    end

    specify('#id') { expect(subject.id).to eq '424' }
  end
end