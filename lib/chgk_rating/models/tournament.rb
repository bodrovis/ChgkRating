module ChgkRating
  module Models
    class Tournament < Base
      def team_players(team_id)
        ChgkRating::Collections::TournamentPlayers.new tournament_id: @id, team_id: team_id
      end

      def team_results(team_id)
        ChgkRating::Collections::TournamentTeamResults.new tournament_id: @id, team_id: team_id
      end

      def team_list
        ChgkRating::Collections::TournamentTeams.new tournament_id: @id
      end

      def team(team_id)
        ChgkRating::Models::TournamentTeam.new team_id, tournament_id: @id, lazy: true
      end

      private

      def api_path
        'tournaments'
      end
    end
  end
end