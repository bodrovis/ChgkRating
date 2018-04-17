module ChgkRating
  module Collections
    class Ratings < Base
      attr_reader :team

      def initialize(params = {})
        @team = build_model params[:team]
        @player = build_model params[:player], ChgkRating::Models::Player
        super
      end

      private

      def process(*_args)
        super { |result| ChgkRating::Models::Rating.new result }
      end

      def api_path
        @team ? "teams/#{@team.id}/rating" : "players/#{@player.id}/rating"
      end
    end
  end
end