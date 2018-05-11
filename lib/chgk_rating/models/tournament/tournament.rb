module ChgkRating
  module Models
    class Tournament < Base
      # Returns an array-like TournamentTeamPlayers collection containing roster for a team at the current tournament.
      #
      # @raise [ChgkRating::Error::NotFound] Error raised when the requested Team cannot be found.
      # @return [ChgkRating::Collection::TournamentTeamPlayers] The collection of results.
      # @param team_or_id [String, Integer or ChgkRating::Models::Team] Team to load players for.
      def team_players(team_or_id)
        ChgkRating::Collections::TournamentTeamPlayers.new tournament: self, team: team_or_id
      end

      # Returns an array-like TournamentTeamResults collection with results for a given team in the current
      # tournament
      #
      # @raise [ChgkRating::Error::NotFound] Error raised when the requested Team cannot be found.
      # @return [ChgkRating::Collection::TournamentTeamResults] The collection of results.
      # @param team_or_id [String, Integer or ChgkRating::Models::Team] Team to load results for.
      def team_results(team_or_id)
        ChgkRating::Collections::TournamentTeamResults.new tournament: self, team: team_or_id
      end

      # Returns an array-like TournamentTeams collection specifying which teams participated in the current tournament
      #
      # @return [ChgkRating::Collection::Ratings] The collection of teams.
      def team_list
        ChgkRating::Collections::TournamentTeams.new tournament: self
      end

      # Returns information about a single TournamentTeam in the current tournament
      #
      # @raise [ChgkRating::Error::NotFound] Error raised when the requested Team cannot be found.
      # @return [ChgkRating::Models::TournamentTeam] The requested TournamentTeam.
      # @param team_or_id [String, Integer or Team] Team to search for.
      def team_by(team_or_id)
        ChgkRating::Models::TournamentTeam.new team_or_id, tournament: self, lazy: true
      end

      private

      def api_path
        'tournaments'
      end
    end
  end
end