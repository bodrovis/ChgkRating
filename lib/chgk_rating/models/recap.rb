module ChgkRating
  module Models
    class Recap < Base
      no_eager_loading!
      no_lazy_support!
      attr_reader :team_id, :season_id, :players, :captain

      #def initialize(season_id_or_hash, team_id = nil)
      def initialize(season_id_or_hash, params = {})
        @team_id = params[:team_id]
        super
      end

      private

      def api_path
        "teams/#{@team_id}/recaps"
      end

      def extract_from(data)
        @team_id = data['idteam']
        @season_id = data['idseason']
        @players = ChgkRating::Collections::Players.new collection: data['players'], lazy: true
        @captain = ChgkRating::Models::Player.new data['captain'], lazy: true
      end
    end
  end
end