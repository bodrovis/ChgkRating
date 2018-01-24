RSpec.shared_examples 'lazy loaded' do
  it 'is lazy loaded' do
    expect(object.lazy).to eq(true)
  end
end

RSpec.shared_examples 'tournament players' do
  it 'should return player info' do
    expect(player.id).to eq '51249'
    expect(player.is_captain).to eq true
    expect(player.is_base).to eq true
    expect(player.is_foreign).to eq false
  end
end

RSpec.shared_examples 'tournament results' do
  it 'should return result for a tour' do
    expect(team_result.result).to eq [false, false, false, false, true, true,
                                      true, false, false, true, false, false]
    expect(team_result.tour).to eq(1)
  end
end

RSpec.describe ChgkRating::Client do
  context 'errors' do
    it 'should raise an error for an erroneous request' do
      expect( -> { VCR.use_cassette 'erroneous_request' do
        test_client.tournament '/thats/an/error'
      end } ).to raise_error(ChgkRating::Error::NotFound)
    end
  end

  describe '#team_at_tournament' do
    subject { test_client.team_at_tournament 3506, 52853 }

    it { is_expected.to be_an_instance_of ChgkRating::Models::TournamentTeam }

    include_examples 'lazy loaded' do
      let(:object) { subject }
    end
  end

  describe '#tournament' do
    let(:lazy_tournament) { test_client.tournament 3506, true }
    let(:tournament) do
      VCR.use_cassette 'tournament' do
        test_client.tournament 3506
      end
    end
    let(:player) do
      recap = VCR.use_cassette 'team_players_at_tournament' do
        tournament.team_players 52853
      end
      recap[0]
    end
    let(:team_result) do
      results = VCR.use_cassette 'team_results_at_tournament' do
        tournament.team_results 52853
      end
      results[0]
    end

    include_examples 'tournament results'

    include_examples 'tournament players'

    include_examples 'lazy loaded' do
      let(:object) { lazy_tournament }
    end

    it 'should return full info' do
      expect(tournament).to be_an_instance_of ChgkRating::Models::Tournament
      expect(tournament.id).to eq '3506'
      expect(tournament.name).to eq 'Чемпионат Перми и Пермского края'
      expect(tournament.long_name).to eq 'XV Чемпионат Перми и Пермского края по игре "Что? Где? Когда?"'
      expect(tournament.date_start).to eq DateTime.parse('2015-11-08 14:00:00')
      expect(tournament.date_end).to eq DateTime.parse('2015-11-08 18:00:00')
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

    it 'should support eager loading' do
      VCR.use_cassette 'tournament' do
        lazy_tournament.eager_load!
      end
      expect(lazy_tournament.name).to eq 'Чемпионат Перми и Пермского края'
    end
  end

  describe '#rating' do
    subject do
      VCR.use_cassette('rating_release') { test_client.rating 1, 24 }
    end

    it { is_expected.to be_an_instance_of ChgkRating::Models::Rating }
  end

  describe '#recap' do
    it 'should allow to choose the last season' do
      recap = VCR.use_cassette 'recap_last_season' do
        test_client.recap 7931, :last
      end

      expect(recap).to be_an_instance_of ChgkRating::Models::Recap
      expect(recap.season_id).to eq '51'
      expect(recap.team.id).to eq '7931'
      expect(recap.captain.id).to eq '23539'
      expect(recap.players.first.id).to eq '2668'
    end

    it 'should allow to provide season number' do
      recap = VCR.use_cassette 'recap' do
        test_client.recap 1, 9
      end

      expect(recap.season_id).to eq '9'
      expect(recap.team.id).to eq '1'
      expect(recap.captain.id).to eq '2935'
      expect(recap.players.first.id).to eq '2935'
    end
  end

  describe '#team' do
    subject { test_client.team 1, true }

    it { is_expected.to be_an_instance_of ChgkRating::Models::Team }

    include_examples 'lazy loaded' do
      let(:object) { subject }
    end
  end

  describe '#player' do
    subject { test_client.player 42511, true }

    it { is_expected.to be_an_instance_of ChgkRating::Models::Player }

    include_examples 'lazy loaded' do
      let(:object) { subject }
    end
  end

  describe '#ratings' do
    it 'should return all ratings for a team' do
      ratings = VCR.use_cassette 'team_ratings' do
        test_client.ratings 1
      end
      team_rating = ratings[0]
      expect(team_rating.date.to_s).to eq '2003-07-01'
      expect(team_rating.formula).to eq :a
      expect(team_rating.rating_position).to eq 8
      expect(team_rating.release_id).to eq '1'
      expect(team_rating.team.id).to eq '1'
      expect(team_rating.rating).to eq 6093
    end
  end

  describe '#team_players_at_tournament' do
    let(:player) do
      recap = VCR.use_cassette 'team_players_at_tournament' do
        test_client.team_players_at_tournament 3506, 52853
      end
      recap[0]
    end
    include_examples 'tournament players'
  end

  describe '#team_results_at_tournament' do
    let(:team_result) do
      results = VCR.use_cassette 'team_results_at_tournament' do
        test_client.team_results_at_tournament 3506, 52853
      end
      results[0]
    end

    include_examples 'tournament results'
  end

  describe '#teams_at_tournament' do
    it 'should return all teams' do
      teams = VCR.use_cassette 'teams_at_tournament' do
        test_client.teams_at_tournament 3506
      end
      team = teams[0]

      expect(team.id).to eq '2124'
      expect(team.current_name).to eq 'Полосатый мамонт'
      expect(team.base_name).to eq 'Полосатый мамонт'
      expect(team.position).to eq 3
      expect(team.questions_total).to eq 34
      expect(team.bonus_a).to eq 1575
      expect(team.bonus_b).to eq -48
      expect(team.tech_rating).to eq 2561
      expect(team.predicted_position).to eq 2
      expect(team.real_bonus_b).to eq 421
      expect(team.d_bonus_b).to eq -48
      expect(team.included_in_rating).to eq true
      expect(team.result).to eq [true, true, true, false, true, true, true, true, true, true, true,
                                 true, true, false, false, false, false, true, true, true, true, true, false, true,
                                 true, true, false, false, true, false, true, true, false, true, true, false, true,
                                 false, true, false, true, true, true, false, true, true, true, true]
    end
  end

  describe '#tournaments' do
    it 'should return tournaments that a team played in a season' do
      tournaments = VCR.use_cassette 'team_tournaments_season' do
        test_client.tournaments team: 1, season_id: 4
      end

      expect(tournaments.first.id).to eq '188'
    end

    it 'should return tournaments for a team' do
      tournaments = VCR.use_cassette 'team_tournaments' do
        test_client.tournaments team: 1
      end
      tournament = tournaments['8'][0]
      expect(tournament.id).to eq '424'
    end

    it 'should return all tournaments' do
      tournaments = VCR.use_cassette 'tournaments' do
        test_client.tournaments
      end
      tournament = tournaments[0]
      expect(tournament.id).to eq '4592'
      expect(tournament.name).to eq 'Гран-при Бауманки. Синхрон'
      expect(tournament.date_start).to eq DateTime.parse('2017-10-29 10:00:00')
      expect(tournament.date_end).to eq DateTime.parse('2018-08-23 10:00:00')
      expect(tournament.type_name).to eq 'Общий зачёт'
    end
  end

  describe '#recaps' do
    it 'should return all recaps for a team' do
      recaps = VCR.use_cassette 'recaps' do
        test_client.recaps(1)
      end
      recap = recaps['6']
      expect(recap.season_id).to eq '6'
      expect(recap.team.id).to eq '1'
      expect(recap.captain.id).to eq '2935'
      expect(recap.players.first.id).to eq '1585'
    end
  end

  describe '#teams' do
    it 'should allow to perform searching' do
      teams = VCR.use_cassette 'teams_searching' do
        test_client.search_teams name: 'э', town: 'мин'
      end
      team = teams[0]
      expect(team.id).to eq '5444'
      expect(team.town).to eq 'Минск'
      expect(team.name).to eq 'Эйфью'
    end

    it 'should return the first page by default' do
      teams = VCR.use_cassette 'teams' do
        test_client.teams
      end
      team = teams[1]
      expect(team.id).to eq '2'
      expect(team.town).to eq 'Москва'
      expect(team.name).to eq 'Афина'
    end

    it 'should allow to request another page' do
      teams = VCR.use_cassette 'teams_page3' do
        test_client.teams page: 3
      end
      team = teams[1]
      expect(team.id).to eq '2285'
      expect(team.town).to eq 'Саранск'
      expect(team.name).to eq 'Эффект внезапности'
    end
  end

  describe '#players' do
    it 'should allow to perform searching' do
      players = VCR.use_cassette 'players_searching' do
        test_client.search_players name: 'вас', surname: 'а'
      end
      player = players[28]
      expect(player.id).to eq '148380'
      expect(player.surname).to eq 'Абросимов'
      expect(player.name).to eq 'Василий'
      expect(player.patronymic).to eq 'Андреевич'
    end

    it 'should return first page by default' do
      players = VCR.use_cassette 'players' do
        test_client.players
      end
      expect(players.count).to eq 1000
      player = players[1]

      expect(player).to be_an_instance_of ChgkRating::Models::Player
      expect(player.id).to eq '6'
      expect(player.surname).to eq 'Абаков'
      expect(player.name).to eq 'Карен'
    end

    it 'should allow to request another page' do
      players = VCR.use_cassette 'players_page3' do
        test_client.players(page: 3)
      end
      expect(players.count).to eq 1000
      player = players[1]
      expect(player.id).to eq '2101'
      expect(player.surname).to eq 'Бажов'
      expect(player.name).to eq 'Иван'
    end
  end
end