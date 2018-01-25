RSpec.describe ChgkRating::Models::Team do
  subject do
    VCR.use_cassette 'team' do
      described_class.new 1
    end
  end
  let(:team_h) { subject.to_h }
  let(:lazy_team) { described_class.new 1, lazy: true }

  it_behaves_like 'model with eager loading'
  it_behaves_like 'model with lazy support'

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

  specify '#to_h' do
    expect(team_h['idteam']).to eq '1'
    expect(team_h['name']).to eq 'Неспроста'
    expect(team_h['town']).to eq 'Москва'
    expect(team_h['comment']).to eq ''
  end

  specify '#eager_load!' do
    VCR.use_cassette 'team' do
      lazy_team.eager_load!
    end
    expect(lazy_team.name).to eq 'Неспроста'
  end

  describe '#at_tournament' do
    it { expect(subject.at_tournament('1000')).to be_an_instance_of ChgkRating::Models::TournamentTeam }
  end

  describe '#rating' do
    let(:team_rating) do
      VCR.use_cassette 'rating_release' do
        subject.rating 24
      end
    end
    it { expect(team_rating).to be_an_instance_of ChgkRating::Models::Rating }
  end

  describe '#recap' do
    let(:team_recap) do
      VCR.use_cassette 'recap' do
        subject.recap 9
      end
    end
    it { expect(team_recap).to be_an_instance_of ChgkRating::Models::Recap }
  end
end