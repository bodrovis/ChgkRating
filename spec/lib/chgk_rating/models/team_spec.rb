RSpec.describe ChgkRating::Models::Team do
  subject do
    VCR.use_cassette 'team' do
      described_class.new 1
    end
  end
  let(:team_h) { subject.to_h }

  specify('#id') { expect(subject.id).to eq '1' }
  specify('#town') { expect(subject.town).to eq 'Москва' }
  specify('#name') { expect(subject.name).to eq 'Неспроста' }
  specify('#comment') { expect(subject.comment).to eq '' }

  specify '#tournaments' do
    tournaments = VCR.use_cassette 'team_tournaments' do
      subject.tournaments['2']
    end

    expect(tournaments[0].id).to eq '54'
    expect(tournaments[1].id).to eq '25'
  end

  specify '#at_tournament' do
    tournament_team = subject.at_tournament '1000'
    expect(tournament_team.id).to eq '1'
    expect(tournament_team.tournament_id).to eq '1000'
  end

  specify '#to_h' do
    expect(team_h['idteam']).to eq '1'
    expect(team_h['name']).to eq 'Неспроста'
    expect(team_h['town']).to eq 'Москва'
    expect(team_h['comment']).to eq ''
  end
end