module ChgkRating
  module Collections
    class Ratings < Base
      include ChgkRating::Concerns::Pagination

      def initialize(params = {})
        @team_id = params[:team_id]

        super
      end

      private

      def process(result, params = {})
        ChgkRating::Models::Rating.new result
      end

      def api_path
        "teams/#{@team_id}/rating"
      end
    end
  end
end