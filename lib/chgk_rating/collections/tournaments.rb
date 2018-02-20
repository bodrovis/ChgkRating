module ChgkRating
  module Collections
    class Tournaments < Base
      attr_reader :team, :season_id

      def initialize(params = {})
        @team = build_model params[:team]

        @season_id = params[:season_id]
        params.merge!(lazy: true) if @team || @season_id
        super
      end

      def revert_to_hash(key, values)
        [
            key,
            {
                'idteam' => @team.id.to_s,
                'idseason' => key,
                'tournaments' => values.map(&:to_h)
            }
        ]
      end

      private

      def process(_results, params = {})
        super do |result|
          if @team && @season_id.nil?
            ChgkRating::Collections::Tournaments.new(collection: result['tournaments'],
                                                     lazy: true).items
          else
            ChgkRating::Models::Tournament.new result, lazy: params[:lazy]
          end
        end
      end

      def api_path
        path = 'tournaments'
        return path unless @team
        path = "teams/#{@team.id}/#{path}"
        return path unless @season_id
        path + "/#{@season_id}"
      end
    end
  end
end