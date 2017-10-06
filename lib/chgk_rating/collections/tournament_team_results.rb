module ChgkRating
  module Collections
    class TournamentTeamResults < Base
      def initialize(params)
        @tournament_id = params[:tournament_id]
        @team_id = params[:team_id]

        super
      end

      private

      def process(*_args)
        super { |result| ChgkRating::Models::TournamentTeamResult.new result }
      end

      def api_path
        "tournaments/#{@tournament_id}/results/#{@team_id}"
      end
    end
  end
end