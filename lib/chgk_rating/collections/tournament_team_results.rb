module ChgkRating
  module Collections
    class TournamentTeamResults < Base
      attr_reader :team, :tournament

      def initialize(params)
        @tournament = build_model params[:tournament], ChgkRating::Models::Tournament
        @team = build_model params[:team]

        super
      end

      private

      def process(*_args)
        super { |result| ChgkRating::Models::TournamentTeamResult.new result }
      end

      def api_path
        "tournaments/#{@tournament.id}/results/#{@team.id}"
      end
    end
  end
end