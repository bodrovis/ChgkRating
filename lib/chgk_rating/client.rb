module ChgkRating
  class Client
    def team(id, lazy = false)
      ChgkRating::Models::Team.new id, lazy: lazy
    end

    def teams(params = {})
      ChgkRating::Collections::Teams.new params
    end

    def player(id, lazy = false)
      ChgkRating::Models::Player.new id, lazy: lazy
    end

    def players(params = {})
      ChgkRating::Collections::Players.new params
    end

    def recap(team_id, season_id)
      team(team_id, true).recap(season_id)
    end

    def recaps(team_id, params = {})
      team(team_id, true).recaps(params)
    end

    def tournament(id, lazy = false)
      ChgkRating::Models::Tournament.new id, lazy: lazy
    end

    def tournaments(team_id = nil, season_id = nil, params = {})
      ChgkRating::Collections::Tournaments.new team_id: team_id, season_id: season_id
    end

    def team_at_tournament(tournament_id, team_id)
      tournament(tournament_id, true).team(team_id)
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