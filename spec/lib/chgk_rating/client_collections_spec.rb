RSpec.describe ChgkRating::Client do
  describe '#recaps' do
    it 'should return all recaps by default' do
      recaps = VCR.use_cassette 'recaps' do
        test_client.recaps(1)
      end
      recap = recaps[0]
      expect(recap.season_id).to eq(6)
      expect(recap.team_id).to eq(1)
      expect(recap.captain.id).to eq(2935)
      expect(recap.players.first.id).to eq(1585)
    end
  end

  describe '#teams' do
    it 'should allow to perform searching' do
      teams = VCR.use_cassette 'teams_searching' do
        test_client.teams
      end
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