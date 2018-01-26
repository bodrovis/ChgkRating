module ChgkRating
  class Client
    # Returns a single Team
    #
    # @raise [ChgkRating::Error::NotFound] Error raised when the Team cannot be found.
    # @return [ChgkRating::Models::Team] The requested Team.
    # @param lazy [Boolean] Should the Team be lazily loaded? Default is `false`.
    def team(id, lazy = false)
      ChgkRating::Models::Team.new id, lazy: lazy
    end

    def player(id, lazy = false)
      ChgkRating::Models::Player.new id, lazy: lazy
    end

    def recap(team_or_id, season_id)
      team(team_or_id, true).recap(season_id)
    end

    def tournament(tournament_or_id, lazy = false)
      ChgkRating::Models::Tournament.new tournament_or_id, lazy: lazy
    end

    def team_at_tournament(tournament_or_id, team_or_id)
      tournament(tournament_or_id, true).team(team_or_id)
    end

    def rating(team_or_id, release_id)
      team(team_or_id, true).rating(release_id)
    end

    # Search

    def search_players(params)
      ChgkRating::Collections::Players.search request: params
    end

    def search_teams(params)
      ChgkRating::Collections::Teams.search request: params
    end

    # Collections

    def teams(params = {})
      ChgkRating::Collections::Teams.new params
    end

    def players(params = {})
      ChgkRating::Collections::Players.new params
    end

    def recaps(team_or_id)
      team(team_or_id, true).recaps
    end

    def tournaments(team: nil, season_id: nil, params: {})
      ChgkRating::Collections::Tournaments.new params.merge(team: team, season_id: season_id)
    end

    def ratings(team_or_id)
      team(team_or_id, true).ratings
    end

    def teams_at_tournament(tournament_id)
      tournament(tournament_id, true).team_list
    end

    def team_results_at_tournament(tournament_or_id, team_or_id)
      team_at_tournament(tournament_or_id, team_or_id).results
    end

    def team_players_at_tournament(tournament_or_id, team_or_id)
      team_at_tournament(tournament_or_id, team_or_id).players
    end
  end
end