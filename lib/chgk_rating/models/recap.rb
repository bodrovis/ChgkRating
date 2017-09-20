module ChgkRating
  module Models
    class Recap < Base
      attr_reader :team_id, :season_id, :players, :captain

      def initialize(season_id_or_hash, team_id = nil)
        @team_id = team_id
        raw = raw_by season_id_or_hash

        @season_id = raw['idseason']
        @players = ChgkRating::Collections::Players.new raw['players'], true
        @captain = ChgkRating::Models::Player.new raw['captain'], true
      end

      private

      def api_path
        "teams/#{@team_id}/recaps"
      end
    end
  end
end