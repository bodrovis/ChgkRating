RSpec.describe ChgkRating::Models::Tournament do
  subject do
    VCR.use_cassette 'tournament' do
      described_class.new 3506
    end
  end
  let(:lazy_tournament) { described_class.new 3506, lazy: true }
  let(:tournament_h) { subject.to_h }

  it_behaves_like 'model with eager loading'
  it_behaves_like 'model with lazy support'

  specify('#id') { expect(subject.id).to eq '3506' }
  specify('#name') { expect(subject.name).to eq 'Чемпионат Перми и Пермского края' }
  specify('#long_name') { expect(subject.long_name).to eq 'XV Чемпионат Перми и Пермского края по игре "Что? Где? Когда?"' }
  specify('#date_start') { expect(subject.date_start).to eq DateTime.parse('2015-11-08 14:00:00') }
  specify('#date_end') { expect(subject.date_end).to eq DateTime.parse('2015-11-08 18:00:00') }
  specify('#tour_count') { expect(subject.tour_count).to eq 4 }
  specify('#tour_questions') { expect(subject.tour_questions).to eq 12 }
  specify('#tour_ques_per_tour') { expect(subject.tour_ques_per_tour).to eq 0 }
  specify('#questions_total') { expect(subject.questions_total).to eq 48 }
  specify('#type_name') { expect(subject.type_name).to eq 'Обычный' }
  specify('#main_payment_value') { expect(subject.main_payment_value).to eq 660 }
  specify('#discounted_payment_value') { expect(subject.discounted_payment_value).to eq 360 }
  specify('#discounted_payment_reason') { expect(subject.discounted_payment_reason).to eq 'для детских команд; 480 - для студенческих' }
  specify('#date_requests_allowed_to') { expect(subject.date_requests_allowed_to).to be_nil }
  specify('#comment') { expect(subject.comment).to eq '' }
  specify('#town') { expect(subject.town).to eq 'Пермь' }
  specify('#site_url') { expect(subject.site_url).to eq URI.parse('https://vk.com/chgk.perm.championship') }
  specify '#to_h' do
    expect(tournament_h['idtournament']).to eq '3506'
    expect(tournament_h['date_start']).to eq '2015-11-08T14:00:00+00:00'
    expect(tournament_h['date_end']).to eq '2015-11-08T18:00:00+00:00'
    expect(tournament_h['tour_count']).to eq '4'
    expect(tournament_h['tour_questions']).to eq '12'
    expect(tournament_h['tour_ques_per_tour']).to eq '0'
    expect(tournament_h['questions_total']).to eq '48'
    expect(tournament_h['main_payment_value']).to eq '660.0'
    expect(tournament_h['discounted_payment_value']).to eq '360.0'
    expect(tournament_h['date_requests_allowed_to']).to eq ''
    expect(tournament_h['site_url']).to eq 'https://vk.com/chgk.perm.championship'
    expect(tournament_h['name']).to eq 'Чемпионат Перми и Пермского края'
    expect(tournament_h['town']).to eq 'Пермь'
    expect(tournament_h['long_name']).to eq 'XV Чемпионат Перми и Пермского края по игре "Что? Где? Когда?"'
    expect(tournament_h['type_name']).to eq 'Обычный'
    expect(tournament_h['discounted_payment_reason']).to eq 'для детских команд; 480 - для студенческих'
    expect(tournament_h['comment']).to eq ''
  end

  specify '#eager_load!' do
    VCR.use_cassette 'tournament' do
      lazy_tournament.eager_load!
    end
    expect(lazy_tournament.name).to eq 'Чемпионат Перми и Пермского края'
  end

  describe '#team_results' do
    let(:team_results) do
      VCR.use_cassette 'team_results_at_tournament' do
        subject.team_results(52853)
      end
    end

    it { expect(team_results).to be_an_instance_of ChgkRating::Collections::TournamentTeamResults }
  end

  describe '#team_players' do
    let(:players) do
      VCR.use_cassette 'team_players_at_tournament' do
        subject.team_players(52853)
      end
    end

    it { expect(players).to be_an_instance_of ChgkRating::Collections::TournamentPlayers }
  end

  describe '#team' do
    let(:team) { subject.team 52853 }

    it { expect(team).to be_an_instance_of ChgkRating::Models::TournamentTeam }
  end

  describe '#team_list' do
    let(:team_list) do
      VCR.use_cassette 'teams_at_tournament' do
        subject.team_list
      end
    end

    it { expect(team_list).to be_an_instance_of ChgkRating::Collections::TournamentTeams }
  end
end