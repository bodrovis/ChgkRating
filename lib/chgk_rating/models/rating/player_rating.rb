module ChgkRating
  module Models
    class PlayerRating < Rating
      def initialize(release_id_or_hash, params = {})
        @player_id = extract_id_from params[:player], ChgkRating::Models::Player
        super
      end

      private

      def api_path
        "players/#{@player_id}/rating"
      end
    end
  end
end