module ChgkRating
  class Client
    def search(resource, params = {})
      get "#{resource}/search", params
    end

    def recaps(team_id)
      team(team_id, true).recaps
    end

    def recap(team_id, season_id)
      team(team_id, true).recap(season_id)
    end

    def team(id, lazy = false)
      ChgkRating::Models::Team.new id, lazy
    end

    def teams(params = {})
      ChgkRating::Collections::Teams.new params
    end

    def player(id, lazy = false)
      ChgkRating::Models::Player.new id, lazy
    end

    def players(params = {})
      ChgkRating::Collections::Players.new params
    end
  end
end