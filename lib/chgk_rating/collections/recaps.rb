module ChgkRating
  module Collections
    class Recaps < Base
      def initialize(team_id, params = {})
        path = "teams/#{team_id}/recaps"
        @items = get(path, params).values.
            map {|raw_recap| ChgkRating::Models::Recap.new(raw_recap, team_id: team_id) }
      end
    end
  end
end