module ChgkRating
  module Collections
    class Recaps < Base
      attr_reader :team

      def initialize(params = {})
        @team = build_model params[:team]

        super
      end

      private

      def process(results, _params)
        results.each do |season,value|
          results[season] = ChgkRating::Models::Recap.new value, team: @team
        end
      end

      def api_path
        "teams/#{@team.id}/recaps"
      end
    end
  end
end