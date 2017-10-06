module ChgkRating
  module Collections
    class Ratings < Base
      def initialize(params = {})
        @team_id = params[:team_id]

        super
      end

      private

      def process(*_args)
        super { |result| ChgkRating::Models::Rating.new result }
      end

      def api_path
        "teams/#{@team_id}/rating"
      end
    end
  end
end