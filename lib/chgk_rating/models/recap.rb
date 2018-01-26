module ChgkRating
  module Models
    class Recap < Base
      no_eager_loading!
      no_lazy_support!
      attr_reader :team

      def initialize(season_id_or_hash, params = {})
        @team = build_model params[:team]
        super
      end

      private

      def api_path
        "teams/#{@team.id}/recaps"
      end
    end
  end
end