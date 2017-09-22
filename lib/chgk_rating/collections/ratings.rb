module ChgkRating
  module Collections
    class Ratings < Base
      def initialize(team_id)
        path = "teams/#{team_id}/rating"
        @items = get(path).map {|raw_release| ChgkRating::Models::Rating.new(raw_release) }
      end
    end
  end
end