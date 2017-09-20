module ChgkRating
  module Collections
    class Teams < Base
      def initialize(params = {})
        @items = get('teams', params)['items'].map {|raw_team| ChgkRating::Models::Team.new(raw_team) }
      end
    end
  end
end