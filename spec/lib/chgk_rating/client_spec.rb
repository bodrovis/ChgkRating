RSpec.describe ChgkRating::Client do
  specify '#team' do
    teams = VCR.use_cassette 'teams' do
      test_client.teams
    end
    team = teams[1]
    expect(team.id).to eq '2'
    expect(team.town).to eq 'Москва'
    expect(team.name).to eq 'Афина'
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

    it 'should allow to select another page' do
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