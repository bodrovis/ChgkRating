module ChgkRating
  module Models
    class Rating < Base
      no_eager_loading!
      no_lazy_support!

      def initialize(release_id_or_hash, params = {})
        @team_id = extract_id_from params[:team]
        @player_id = extract_id_from params[:player], ChgkRating::Models::Player
        super
      end

      private

      def api_path
        @team_id ? "teams/#{@team_id}/rating" : "players/#{@player_id}/rating"
      end
    end
  end
end