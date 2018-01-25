RSpec.shared_examples 'lazy loaded' do
  it 'is lazy loaded' do
    expect(object.lazy).to eq(true)
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
    subject { test_client.tournament 3506, true }

    include_examples 'lazy loaded' do
      let(:object) { subject }
    end

    it { is_expected.to be_an_instance_of ChgkRating::Models::Tournament }
  end

  describe '#rating' do
    subject do
      VCR.use_cassette('rating_release') { test_client.rating 1, 24 }
    end

    it { is_expected.to be_an_instance_of ChgkRating::Models::Rating }
  end

  describe '#recap' do
    subject do
      VCR.use_cassette 'recap_last_season' do
        test_client.recap 7931, :last
      end
    end

    it { is_expected.to be_an_instance_of ChgkRating::Models::Recap }
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
    subject do
      VCR.use_cassette 'team_ratings' do
        test_client.ratings 1
      end
    end
    it { is_expected.to be_an_instance_of ChgkRating::Collections::Ratings }
  end

  describe '#team_players_at_tournament' do
    subject do
      VCR.use_cassette 'team_players_at_tournament' do
        test_client.team_players_at_tournament 3506, 52853
      end
    end

    it { is_expected.to be_an_instance_of ChgkRating::Collections::TournamentPlayers }
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
    context 'all tournaments for a team by season' do
      subject do
        VCR.use_cassette 'team_tournaments_season' do
          test_client.tournaments team: 1, season_id: 4
        end
      end

      it { is_expected.to be_an_instance_of ChgkRating::Collections::Tournaments }
    end

    context 'tournaments for a team' do
      subject do
        VCR.use_cassette 'team_tournaments' do
          test_client.tournaments team: test_client.team(1, true)
        end
      end

      it { is_expected.to be_an_instance_of ChgkRating::Collections::Tournaments }
    end

    context 'all tournaments' do
      subject do
        VCR.use_cassette 'tournaments' do
          test_client.tournaments
        end
      end

      it { is_expected.to be_an_instance_of ChgkRating::Collections::Tournaments }
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