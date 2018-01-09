module ChgkRating
  module Collections
    class TournamentTeams < Base
      def initialize(params = {})
        @tournament_id = params[:tournament_id]

        super
      end

      private

      def process(_results, params = {})
        super { |result| ChgkRating::Models::TournamentTeam.new result, lazy: params[:lazy] }
      end

      def api_path
        "tournaments/#{@tournament_id}/list"
      end
    end
  end
end