module ChgkRating
  module Collections
    class TournamentTeamPlayers < Base
      attr_reader :team, :tournament

      def initialize(params = {})
        @tournament = build_model params[:tournament], ChgkRating::Models::Tournament
        @team = build_model params[:team]

        super
      end

      private

      def process(*_args)
        super { |result| ChgkRating::Models::TournamentTeamPlayer.new result }
      end

      def api_path
        "tournaments/#{@tournament.id}/recaps/#{@team.id}"
      end
    end
  end
end