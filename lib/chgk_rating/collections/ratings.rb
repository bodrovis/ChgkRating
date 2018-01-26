module ChgkRating
  module Collections
    class Ratings < Base
      attr_reader :team

      def initialize(params = {})
        @team = build_model params[:team]

        super
      end

      private

      def process(*_args)
        super { |result| ChgkRating::Models::Rating.new result }
      end

      def api_path
        "teams/#{@team.id}/rating"
      end
    end
  end
end