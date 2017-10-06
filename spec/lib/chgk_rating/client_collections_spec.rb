RSpec.describe ChgkRating::Client do
  describe '#tournaments' do
    it 'should return tournaments that a team played in a season' do
      tournaments = VCR.use_cassette 'team_tournaments_season' do
        test_client.tournaments team_id: 1, season_id: 4
      end

      expect(tournaments.first.id).to eq '188'
    end

    it 'should return tournaments for a team' do
      tournaments = VCR.use_cassette 'team_tournaments' do
        test_client.tournaments team_id: 1
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
      expect(tournament.date_start).to eq Date.parse('2017-10-29 10:00:00')
      expect(tournament.date_end).to eq Date.parse('2018-08-23 10:00:00')
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
      expect(recap.team_id).to eq '1'
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