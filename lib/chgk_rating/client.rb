module ChgkRating
  class Client
    # Models

    def team(id, lazy = false)
      ChgkRating::Models::Team.new id, lazy: lazy
    end

    def player(id, lazy = false)
      ChgkRating::Models::Player.new id, lazy: lazy
    end

    def recap(team_id, season_id)
      team(team_id, true).recap(season_id)
    end

    def tournament(id, lazy = false)
      ChgkRating::Models::Tournament.new id, lazy: lazy
    end

    def team_at_tournament(tournament_id, team_id)
      tournament(tournament_id, true).team(team_id)
    end

    def rating(team_id, release_id)
      team(team_id, true).rating(release_id)
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

    def recaps(team_id)
      team(team_id, true).recaps
    end

    def tournaments(team: nil, season_id: nil, params: {})
      ChgkRating::Collections::Tournaments.new params.merge(team: team, season_id: season_id)
    end

    def ratings(team_id)
      team(team_id, true).ratings
    end

    def teams_at_tournament(tournament_id)
      tournament(tournament_id, true).team_list
    end

    def team_results_at_tournament(tournament_id, team_id)
      team_at_tournament(tournament_id, team_id).results
    end

    def team_players_at_tournament(tournament_id, team_id)
      team_at_tournament(tournament_id, team_id).players
    end
  end
end