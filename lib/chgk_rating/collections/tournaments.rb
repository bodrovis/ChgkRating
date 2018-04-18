module ChgkRating
  module Collections
    class Tournaments < Base
      attr_reader :team, :season_id, :player

      def initialize(params = {})
        @team = build_model params[:team]
        @player = build_model params[:player], ChgkRating::Models::Player

        @season_id = params[:season_id]
        params.merge!(lazy: true) if @team || @season_id || @player
        super
      end

      def revert_to_hash(key, values)
        [
            key,
            {
                'idteam' => @team&.id.to_s,
                'idplayer' => @player&.id.to_s,
                'idseason' => key,
                'tournaments' => values.map(&:to_h)
            }
        ]
      end

      private

      def process(_results, params = {})
        super do |result|
          if (@team || @player) && @season_id.nil?
            ChgkRating::Collections::Tournaments.new(collection: result['tournaments'],
                                                     lazy: true).items
          else
            ChgkRating::Models::Tournament.new result, lazy: params[:lazy]
          end
        end
      end

      # @return [String] Either `tournaments`, `teams/ID/tournaments`, `players/ID/tournaments`, `teams/ID/tournaments/SEASON_ID`, `players/ID/tournaments/SEASON_ID`
      def api_path
        path = 'tournaments'
        return path unless @team || @player
        path = _team_or_player_for path
        return path unless @season_id
        path + "/#{@season_id}"
      end

      def _team_or_player_for(path)
        if @team
          "teams/#{@team.id}"
        else
          "players/#{@player.id}"
        end + "/#{path}"
      end
    end
  end
end