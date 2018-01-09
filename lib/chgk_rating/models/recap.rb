module ChgkRating
  module Models
    class Recap < Base
      no_eager_loading!
      no_lazy_support!
      attr_reader :team_id

      def initialize(season_id_or_hash, params = {})
        @team_id = params[:team_id]
        super
      end

      private

      def api_path
        "teams/#{@team_id}/recaps"
      end
    end
  end
end