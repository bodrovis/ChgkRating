module ChgkRating
  module Collections
    class TournamentTeams < Base
      include ChgkRating::Concerns::Pagination

      def initialize(params = {})
        @tournament_id = params[:tournament_id]

        super
      end

      private

      def process(result, params = {})
        ChgkRating::Models::TournamentTeam.new result
      end

      def api_path
        "tournaments/#{@tournament_id}/list"
      end
    end
  end
end