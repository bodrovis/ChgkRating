module ChgkRating
  module Models
    class TournamentTeam < Base
      no_eager_loading!

      attr_reader :tournament, :team

      def initialize(team_or_hash, params = {})
        @team = build_model team_or_hash
        @tournament = build_model params[:tournament], ChgkRating::Models::Tournament
        super extract_id_from(team_or_hash), params
      end

      def players
        ChgkRating::Collections::TournamentPlayers.new tournament: @tournament, team: @team
      end

      def results
        ChgkRating::Collections::TournamentTeamResults.new tournament: @tournament, team: @team
      end

      private

      def extract_id_from(obj)
        return obj unless obj.is_a?(ChgkRating::Models::Team)
        obj.id
      end
    end
  end
end