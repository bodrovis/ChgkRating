module ChgkRating
  module Collections
    class PlayerTournaments < Base
      attr_reader :season_id, :player

      def initialize(params = {})
        @player = build_model params[:player], ChgkRating::Models::Player

        @season_id = params[:season_id]
        super
      end

      def revert_to_hash(key, values)
        [
            key,
            {
                'idplayer' => @player.id.to_s,
                'idseason' => key,
                'tournaments' => values.map(&:to_h)
            }
        ]
      end

      private

      def process(_results, params = {})
        super do |result|
          if @player && @season_id.nil?
            ChgkRating::Collections::PlayerTournaments.new(collection: result['tournaments']).items
          else
            ChgkRating::Models::PlayerTournament.new result
          end
        end
      end

      # @return [String] Either `tournaments`, `teams/ID/tournaments`, `players/ID/tournaments`, `teams/ID/tournaments/SEASON_ID`, `players/ID/tournaments/SEASON_ID`
      def api_path
        path = "players/#{@player.id}/tournaments"
        return path unless @season_id
        path + "/#{@season_id}"
      end
    end
  end
end