module ChgkRating
  module Collections
    class Recaps < Base
      attr_reader :team_id

      def initialize(params = {})
        @team_id = params[:team_id]

        super
      end

      private

      def process(results, _params)
        results.each do |season,value|
          results[season] = ChgkRating::Models::Recap.new value, team_id: @team_id
        end
      end

      def api_path
        "teams/#{@team_id}/recaps"
      end
    end
  end
end