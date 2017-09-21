module ChgkRating
  module Models
    class Recap < Base
      attr_reader :team_id, :season_id, :players, :captain

      def initialize(season_id_or_hash, team_id = nil)
        @team_id = team_id
        super season_id_or_hash, false
      end

      private

      def api_path
        "teams/#{@team_id}/recaps"
      end

      def extract_from(data)
        @season_id = data['idseason']
        @players = ChgkRating::Collections::Players.new data['players'], true
        @captain = ChgkRating::Models::Player.new data['captain'], true
      end
    end
  end
end