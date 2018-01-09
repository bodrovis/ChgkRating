module ChgkRating
  module Models
    class TournamentTeam < Base
      no_eager_loading!

      attr_reader :tournament_id

      def initialize(team_id_or_hash, params = {})
        @tournament_id = params[:tournament_id]
        super
      end

      def players
        ChgkRating::Collections::TournamentPlayers.new tournament_id: @tournament_id, team_id: @id
      end

      def results
        ChgkRating::Collections::TournamentTeamResults.new tournament_id: @tournament_id, team_id: @id
      end
    end
  end
end