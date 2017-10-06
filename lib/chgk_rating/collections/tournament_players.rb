module ChgkRating
  module Collections
    class TournamentPlayers < Base
      def initialize(params = {})
        @tournament_id = params[:tournament_id]
        @team_id = params[:team_id]

        super
      end

      private

      def process(*_args)
        super { |result| ChgkRating::Models::TournamentPlayer.new result }
      end

      def api_path
        "tournaments/#{@tournament_id}/recaps/#{@team_id}"
      end
    end
  end
end