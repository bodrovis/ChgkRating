module ChgkRating
  module Collections
    class Tournaments < Base
      attr_reader :lazy, :team, :season_id

      def initialize(team_or_id: nil, season_id: nil, params: {}, lazy: true)
        @team = if team_or_id.instance_of?(ChgkRating::Models::Team)
                  team_or_id
                else
                  ChgkRating::Models::Team.new(team_or_id, true) if team_or_id
                end
        @season_id = season_id

        result = get(api_path, params)
        @items = result[result.has_key?('items') ? 'items' : 'tournaments'].map do |raw_tournament|
          ChgkRating::Models::Tournament.new raw_tournament, true
        end
        @lazy = lazy
      end

      private

      def api_path
        path = 'tournaments'
        return path unless @team
        path = "#{@team.api_path}/#{@team.id}/#{path}"
        return path unless @season_id
        path += "/#{@season_id}"
      end
    end
  end
end