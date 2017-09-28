RSpec.shared_examples 'lazy loaded' do
  it 'is lazy loaded' do
    expect(object.lazy).to eq(true)
  end
end

RSpec.describe ChgkRating::Client do
  describe '#team_at_tournament' do
    subject { test_client.team_at_tournament 3506, 52853 }

    include_examples 'lazy loaded' do
      let(:object) { subject.team }
    end

    it 'should contain only lazily loaded data' do
      binding.pry
      expect(subject.tournament_id).to eq(3506)
      puts subject.inspect
    end
  end

  describe '#tournament' do
    include_examples 'lazy loaded' do
      let(:object) { test_client.tournament 3506, true }
    end

    it 'should request full info by default' do
      tournament = VCR.use_cassette 'tournament' do
        test_client.tournament 3506
      end

      expect(tournament).to be_an_instance_of ChgkRating::Models::Tournament
      expect(tournament.id).to eq '3506'
      expect(tournament.name).to eq 'Чемпионат Перми и Пермского края'
      expect(tournament.long_name).to eq 'XV Чемпионат Перми и Пермского края по игре "Что? Где? Когда?"'
      expect(tournament.date_start).to eq Date.parse('2015-11-08 14:00:00')
      expect(tournament.date_end).to eq Date.parse('2015-11-08 18:00:00')
      expect(tournament.tour_count).to eq 4
      expect(tournament.tour_questions).to eq 12
      expect(tournament.tour_ques_per_tour).to eq 0
      expect(tournament.questions_total).to eq 48
      expect(tournament.type_name).to eq 'Обычный'
      expect(tournament.main_payment_value).to eq 660
      expect(tournament.discounted_payment_value).to eq 360
      expect(tournament.discounted_payment_reason).to eq 'для детских команд; 480 - для студенческих'
      expect(tournament.date_requests_allowed_to).to be_nil
      expect(tournament.comment).to eq ''
      expect(tournament.site_url).to eq URI.parse('https://vk.com/chgk.perm.championship')
    end
  end

  context '#recap' do
    it 'should allow to choose the last season' do
      recap = VCR.use_cassette 'recap_last_season' do
        test_client.recap 7931, :last
      end

      expect(recap).to be_an_instance_of ChgkRating::Models::Recap
      expect(recap.season_id).to eq '51'
      expect(recap.team_id).to eq '7931'
      expect(recap.captain.id).to eq '23539'
      expect(recap.players.first.id).to eq '2668'
    end

    it 'should allow to provide season number' do
      recap = VCR.use_cassette 'recap' do
        test_client.recap 1, 9
      end

      expect(recap.season_id).to eq '9'
      expect(recap.team_id).to eq '1'
      expect(recap.captain.id).to eq '2935'
      expect(recap.players.first.id).to eq '2935'
    end
  end

  specify '#team' do
    team = VCR.use_cassette 'team' do
      test_client.team(1)
    end

    expect(team).to be_an_instance_of ChgkRating::Models::Team
    expect(team.id).to eq '1'
    expect(team.town).to eq 'Москва'
    expect(team.name).to eq 'Неспроста'
  end

  specify '#player' do
    player = VCR.use_cassette 'player' do
      test_client.player(42511)
    end

    expect(player).to be_an_instance_of ChgkRating::Models::Player
    expect(player.id).to eq '42511'
    expect(player.surname).to eq 'Некрылов'
    expect(player.name).to eq 'Николай'
    expect(player.patronymic).to eq 'Андреевич'
    expect(player.db_chgk_info_tag).to eq 'nnekrylov'
  end
end