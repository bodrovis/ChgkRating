module ChgkRating
  module Models
    class Tournament < Base
      def team_players(team)
        ChgkRating::Collections::TournamentPlayers.new tournament: self, team: team
      end

      def team_results(team)
        ChgkRating::Collections::TournamentTeamResults.new tournament: self, team: team
      end

      def team_list
        ChgkRating::Collections::TournamentTeams.new tournament: self
      end

      def team(team)
        ChgkRating::Models::TournamentTeam.new team, tournament: self, lazy: true
      end

      private

      def api_path
        'tournaments'
      end
    end
  end
end