RSpec.describe ChgkRating::Client do
  context '#teams' do
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

  context '#players' do
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