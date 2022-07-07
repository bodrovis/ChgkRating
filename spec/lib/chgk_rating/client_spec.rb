# frozen_string_literal: true

RSpec.shared_examples 'lazy loaded' do
  it 'is lazy loaded' do
    expect(object.lazy).to be(true)
  end
end

RSpec.describe ChgkRating::Client do
  let(:team_1) { test_client.team(1, true) }
  let(:team_52853) { test_client.team(52_853, true) }
  let(:tournament_3506) { test_client.tournament(3506, true) }

  def with_erroneous_cassette(&block)
    VCR.use_cassette('erroneous_request', &block)
  end

  context 'errors' do
    it 'raises an error for an erroneous request' do
      expect do
        # That's a very strange bug that makes VCR raise UnhandledHTTPError
        # so for now disable VCR for Ruby 2.5+
        if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.5.0')
          test_client.tournament '/thats/an/error'
        else
          with_erroneous_cassette { test_client.tournament '/thats/an/error' }
        end
      end.to raise_error(ChgkRating::Error::NotFound)
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

  describe '#team_rating' do
    subject do
      VCR.use_cassette('rating_release') { test_client.team_rating team_1, 24 }
    end

    it { is_expected.to be_an_instance_of ChgkRating::Models::TeamRating }
  end

  describe '#player_rating' do
    subject do
      VCR.use_cassette('player_rating_release') { test_client.player_rating 42_511, 1000 }
    end

    it { is_expected.to be_an_instance_of ChgkRating::Models::PlayerRating }
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
    subject { test_client.player 42_511, true }

    it { is_expected.to be_an_instance_of ChgkRating::Models::Player }

    include_examples 'lazy loaded' do
      let(:object) { subject }
    end
  end

  describe '#team_ratings' do
    subject do
      VCR.use_cassette 'team_ratings' do
        test_client.team_ratings team_1
      end
    end

    it { is_expected.to be_an_instance_of ChgkRating::Collections::TeamRatings }
  end

  describe '#player_ratings' do
    subject do
      VCR.use_cassette 'player_ratings_all_releases' do
        test_client.player_ratings 42_511
      end
    end

    it { is_expected.to be_an_instance_of ChgkRating::Collections::PlayerRatings }
  end

  describe '#team_players_at_tournament' do
    subject do
      VCR.use_cassette 'team_players_at_tournament' do
        test_client.team_players_at_tournament tournament_3506, team_52853
      end
    end

    it { is_expected.to be_an_instance_of ChgkRating::Collections::TournamentTeamPlayers }
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

  describe '#player_tournaments' do
    context 'all tournaments for a player by season' do
      subject do
        VCR.use_cassette 'player_tournaments_season' do
          test_client.player_tournaments 1000, 51
        end
      end

      it { is_expected.to be_an_instance_of ChgkRating::Collections::PlayerTournaments }
    end

    context 'tournaments for a player' do
      subject do
        VCR.use_cassette 'player_tournaments' do
          test_client.player_tournaments 1000
        end
      end

      it { is_expected.to be_an_instance_of ChgkRating::Collections::PlayerTournaments }
    end
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
