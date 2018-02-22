RSpec.shared_examples 'lazy loaded' do
  it 'is lazy loaded' do
    expect(object.lazy).to eq(true)
  end
end

RSpec.describe ChgkRating::Client do
  let(:team_1) { test_client.team(1, true) }
  let(:team_52853) { test_client.team(52853, true) }
  let(:tournament_3506) { test_client.tournament(3506, true) }

  context 'errors' do
    it 'should raise an error for an erroneous request' do
      expect( -> { VCR.use_cassette 'erroneous_request' do
        test_client.tournament '/thats/an/error'
      end } ).to raise_error(ChgkRating::Error::NotFound)
    end
  end

  describe '#team_at_tournament' do
    subject { test_client.team_at_tournament tournament_3506, team_52853 }

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
      VCR.use_cassette('rating_release') { test_client.rating team_1, 24 }
    end

    it { is_expected.to be_an_instance_of ChgkRating::Models::Rating }
  end

  describe '#recap' do
    subject do
      VCR.use_cassette 'recap_last_season' do
        test_client.recap test_client.team(7931, true), :last
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
        test_client.ratings team_1
      end
    end
    it { is_expected.to be_an_instance_of ChgkRating::Collections::Ratings }
  end

  describe '#team_players_at_tournament' do
    subject do
      VCR.use_cassette 'team_players_at_tournament' do
        test_client.team_players_at_tournament tournament_3506, team_52853
      end
    end

    it { is_expected.to be_an_instance_of ChgkRating::Collections::TournamentPlayers }
  end

  describe '#team_results_at_tournament' do
    subject do
      VCR.use_cassette 'team_results_at_tournament' do
        test_client.team_results_at_tournament tournament_3506, team_52853
      end
    end

    it { is_expected.to be_an_instance_of ChgkRating::Collections::TournamentTeamResults }
  end

  describe '#teams_at_tournament' do
    subject do
      VCR.use_cassette 'teams_at_tournament' do
        test_client.teams_at_tournament tournament_3506
      end
    end

    it { is_expected.to be_an_instance_of ChgkRating::Collections::TournamentTeams }
  end

  describe '#tournaments' do
    context 'all tournaments for a team by season' do
      subject do
        VCR.use_cassette 'team_tournaments_season' do
          test_client.tournaments team_or_id: team_1, season_id: 4
        end
      end

      it { is_expected.to be_an_instance_of ChgkRating::Collections::Tournaments }
    end

    context 'tournaments for a team' do
      subject do
        VCR.use_cassette 'team_tournaments' do
          test_client.tournaments team_or_id: team_1
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
    subject do
      VCR.use_cassette 'recaps' do
        test_client.recaps team_1
      end
    end

    it { is_expected.to be_an_instance_of ChgkRating::Collections::Recaps }
  end

  describe '#search_teams' do
    subject do
      VCR.use_cassette 'teams_searching' do
        test_client.search_teams name: 'э', town: 'мин'
      end
    end

    it { is_expected.to be_an_instance_of ChgkRating::Collections::Teams::Search }
  end

  describe '#teams' do
    subject do
      VCR.use_cassette 'teams' do
        test_client.teams
      end
    end

    it { is_expected.to be_an_instance_of ChgkRating::Collections::Teams }
  end

  describe '#search_players' do
    subject do
      VCR.use_cassette 'players_searching' do
        test_client.search_players name: 'вас', surname: 'а'
      end
    end

    it { is_expected.to be_an_instance_of ChgkRating::Collections::Players::Search }
  end

  describe '#players' do
    subject do
      VCR.use_cassette 'players' do
        test_client.players
      end
    end

    it { is_expected.to be_an_instance_of ChgkRating::Collections::Players }
  end
end