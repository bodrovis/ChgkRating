module ChgkRating
  module Collections
    class Teams < Base
      include ChgkRating::Concerns::Search
      def initialize(params = {})
        @items = get(api_path, params)['items'].map do |raw_team|
          ChgkRating::Models::Team.new raw_team
        end
      end

      def api_path
        'teams'
      end
    end
  end
end