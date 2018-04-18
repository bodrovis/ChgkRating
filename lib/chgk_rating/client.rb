module ChgkRating
  class Client
    # Returns a single Team
    #
    # @raise [ChgkRating::Error::NotFound] Error raised when the Team cannot be found.
    # @return [ChgkRating::Models::Team] The requested Team.
    # @param id [String or Integer] Team's id
    # @param lazy [Boolean] Should the Team be lazily loaded? Default is `false`.
    def team(id, lazy = false)
      ChgkRating::Models::Team.new id, lazy: lazy
    end

    # Returns a single Player
    #
    # @raise [ChgkRating::Error::NotFound] Error raised when the Player cannot be found.
    # @return [ChgkRating::Models::Player] The requested Player.
    # @param id [String or Integer] Player's id
    # @param lazy [Boolean] Should the Player be lazily loaded? Default is `false`.
    def player(id, lazy = false)
      ChgkRating::Models::Player.new id, lazy: lazy
    end

    # Returns a single Recap for a given Team
    #
    # @raise [ChgkRating::Error::NotFound] Error raised when the requested Team cannot be found.
    # @return [ChgkRating::Models::Recap] The requested Recap.
    # @param team_or_id [String, Integer or ChgkRating::Models::Team] Team to load recaps for.
    # @param season_id [String or Integer] Season to load recap for.
    def recap(team_or_id, season_id)
      team(team_or_id, true).recap(season_id)
    end

    # Returns a single Tournament
    #
    # @raise [ChgkRating::Error::NotFound] Error raised when the requested Tournament cannot be found.
    # @return [ChgkRating::Models::Tournament] The requested Tournament.
    # @param id [String or Integer] Tournament's id
    # @param lazy [Boolean] Should the Tournament be lazily loaded? Default is `false`.
    def tournament(id, lazy = false)
      ChgkRating::Models::Tournament.new id, lazy: lazy
    end

    # Returns a single TournamentTeam
    #
    # @raise [ChgkRating::Error::NotFound] Error raised when the requested Tournament or Team cannot be found.
    # @return [ChgkRating::Models::TournamentTeam] The requested TournamentTeam.
    # @param tournament_or_id [String, Integer or Tournament] Tournament to load team for.
    # @param team_or_id [String, Integer or Team] Team to search for.
    def team_at_tournament(tournament_or_id, team_or_id)
      tournament(tournament_or_id, true).team_by(team_or_id)
    end

    # Returns Rating for a given Team in a given release
    #
    # @raise [ChgkRating::Error::NotFound] Error raised when the requested release or Team cannot be found.
    # @return [ChgkRating::Models::Rating] The requested Rating.
    # @param team_or_id [String, Integer or ChgkRating::Models::Team] Team to load rating for.
    # @param release_id [String or Integer] Release to load rating for.
    def team_rating(team_or_id, release_id)
      team(team_or_id, true).rating(release_id)
    end

    # Returns Rating for a given Player in a given release
    #
    # @raise [ChgkRating::Error::NotFound] Error raised when the requested release or Player cannot be found.
    # @return [ChgkRating::Models::Rating] The requested Rating.
    # @param player_or_id [String, Integer or ChgkRating::Models::Team] Player to load rating for.
    # @param release_id [String or Integer] Release to load rating for.
    def player_rating(player_or_id, release_id)
      player(player_or_id, true).rating(release_id)
    end

    # Search

    # Returns a Players collection based on the search criteria.
    #
    # @return [ChgkRating::Collection::Players::Search] Found Players.
    # @option params [String] :name Player's name
    # @option params [String] :surname Player's surname
    # @option params [String] :patronymic Player's patronymic
    # @option params [String or Integer] :page The requested page. Default is 1, and there are 1000 results per page.
    def search_players(params)
      ChgkRating::Collections::Players.search request: params
    end

    # Returns a Teams collection based on the search criteria.
    #
    # @return [ChgkRating::Collection::Teams::Search] Found Teams.
    # @option params [String] :name Team's name
    # @option params [String] :town Team's town of origin
    # @option params [String or Integer] :page The requested page. Default is 1, and there are 1000 results per page.
    def search_teams(params)
      ChgkRating::Collections::Teams.search request: params
    end

    # Collections

    # Returns an array-like Teams collection that contains Team models
    #
    # @return [ChgkRating::Collection::Teams] The collection of Teams.
    # @option params [String or Integer] :page The requested page. Default is 1, and there are 1000 results per page.
    # @option params [Boolean] :lazy Should the Teams models be marked as lazily loaded?
    #                          Note that the models will still contain all the information returned by the API.
    # @option params [Enumerable] :collection An array or collection of Teams that will be used to build a new
    #                             collection. If this option is provided, API request will not be sent.
    def teams(params = {})
      ChgkRating::Collections::Teams.new params
    end

    # Returns an array-like Players collection that contains Player models
    #
    # @return [ChgkRating::Collection::Players] The collection of Players.
    # @option params [String or Integer] :page The requested page. Default is 1, and there are 1000 results per page.
    # @option params [Boolean] :lazy Should the Player models be marked as lazily loaded?
    #                          Note that the models will still contain all the information returned by the API.
    # @option params [Enumerable] :collection An array or collection of Players that will be used to build a new
    #                             collection. If this option is provided, API request will not be sent.
    def players(params = {})
      ChgkRating::Collections::Players.new params
    end

    # Returns an hash-like Recaps collection for a given team, grouped by seasons. Seasons act
    # as keys, whereas Recap models - as values.
    #
    # @raise [ChgkRating::Error::NotFound] Error raised when the requested Team cannot be found.
    # @return [ChgkRating::Collection::Recaps] The collection of recaps.
    # @param team_or_id [String, Integer or ChgkRating::Models::Team] Team to load recaps for.
    def recaps(team_or_id)
      team(team_or_id, true).recaps
    end

    # Returns a collection of Tournaments based on the given criteria
    #
    # @raise [ChgkRating::Error::NotFound] Error raised when nothing can be found based on the given criteria.
    # @return [ChgkRating::Collection::Tournaments] The collection of tournaments.
    # @param team_or_id [String, Integer or ChgkRating::Models::Team] Team to load tournaments for.
    # @param player_or_id [String, Integer or ChgkRating::Models::Player] Player to load tournaments for. Ignored if team_or_id  is provided.
    # @param season_id [String or Integer] Season to load tournaments for
    # @option params [String or Integer] :page The requested page. Default is 1
    def tournaments(team_or_id: nil, player_or_id: nil, season_id: nil, params: {})
      ChgkRating::Collections::Tournaments.new params.merge(
          team: team_or_id, player: player_or_id, season_id: season_id
      )
    end

    # Returns an array-like Ratings collection for a given Team.
    #
    # @raise [ChgkRating::Error::NotFound] Error raised when the requested Team cannot be found.
    # @return [ChgkRating::Collection::Ratings] The collection of ratings.
    # @param team_or_id [String, Integer or ChgkRating::Models::Team] Team to load ratings for.
    def team_ratings(team_or_id)
      team(team_or_id, true).ratings
    end

    # Returns an array-like Ratings collection for a given Player.
    #
    # @raise [ChgkRating::Error::NotFound] Error raised when the requested Player cannot be found.
    # @return [ChgkRating::Collection::Ratings] The collection of ratings.
    # @param player_or_id [String, Integer or ChgkRating::Models::Team] Player to load ratings for.
    def player_ratings(player_or_id)
      player(player_or_id, true).ratings
    end

    # Returns an array-like TournamentTeams collection specifying which teams participated in a given tournament
    #
    # @raise [ChgkRating::Error::NotFound] Error raised when the requested Tournament cannot be found.
    # @return [ChgkRating::Collection::Ratings] The collection of teams.
    # @param tournament_or_id [String, Integer or ChgkRating::Models::Tournament] Tournament to load teams for.
    def teams_at_tournament(tournament_or_id)
      tournament(tournament_or_id, true).team_list
    end

    # Returns an array-like TournamentTeamResults collection with results for a given team in a given
    # tournament
    #
    # @raise [ChgkRating::Error::NotFound] Error raised when the requested Tournament or Team cannot be found.
    # @return [ChgkRating::Collection::TournamentTeamResults] The collection of results.
    # @param tournament_or_id [String, Integer or ChgkRating::Models::Tournament] Tournament to load results for.
    # @param team_or_id [String, Integer or ChgkRating::Models::Team] Team to load results for.
    def team_results_at_tournament(tournament_or_id, team_or_id)
      team_at_tournament(tournament_or_id, team_or_id).results
    end

    # Returns an array-like TournamentPlayers collection containing roster for a
    # given team at a given tournament.
    #
    # @raise [ChgkRating::Error::NotFound] Error raised when the requested Tournament or Team cannot be found.
    # @return [ChgkRating::Collection::TournamentPlayers] The collection of results.
    # @param tournament_or_id [String, Integer or ChgkRating::Models::Tournament] Tournament to load players for.
    # @param team_or_id [String, Integer or ChgkRating::Models::Team] Team to load players for.
    def team_players_at_tournament(tournament_or_id, team_or_id)
      team_at_tournament(tournament_or_id, team_or_id).players
    end
  end
end