module ChgkRating
  module Collections
    class Recaps < Base
      include ChgkRating::Concerns::Pagination

      def initialize(params = {})
        @team_id = params[:team_id]

        super
      end

      private

      def process(result, params = {})
        ChgkRating::Models::Recap.new result, team_id: @team_id
      end

      def api_path
        "teams/#{@team_id}/recaps"
      end
    end
  end
end